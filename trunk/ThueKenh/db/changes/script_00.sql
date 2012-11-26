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
   execute immediate 'truncate table "THUEKENH"."LICHSU_PHULUC" drop storage';
   execute immediate 'truncate table "THUEKENH"."LICHSU_TUYENKENH" drop storage';
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

--------------------------------------------------------
--  DDL for Procedure PROC_DELETE_PHULUC
--------------------------------------------------------
set define off;

  CREATE OR REPLACE PROCEDURE "THUEKENH"."PROC_DELETE_PHULUC" (
pi_array in TABLE_VARCHAR,
usercreate_ in varchar2,
timeaction_ in number
) AS 
i INTEGER := 1;
BEGIN
	--for i in pi_array.first .. pi_array.last loop
	for rec in (SELECT *  FROM PHULUC  where DELETED = 0 and ID in (select * from table(pi_array))) loop
		update PHULUC set DELETED = timeaction_ where ID = rec.ID;
		PROC_INSERT_LICHSU_PHULUC(usercreate_,rec.ID,3,'');
	end loop;
END PROC_DELETE_PHULUC;

/

--------------------------------------------------------
--  DDL for Procedure PROC_DELETE_TUYENKENHDEXUAT
--------------------------------------------------------
set define off;

  CREATE OR REPLACE PROCEDURE "THUEKENH"."PROC_DELETE_TUYENKENHDEXUAT" (
pi_array in TABLE_VARCHAR,
usercreate_ in varchar2,
timeaction_ in number
) AS 
i INTEGER := 1;
str varchar2(500) := '';
BEGIN
	--for i in pi_array.first .. pi_array.last loop
	for rec in (SELECT *  FROM TUYENKENHDEXUAT  where ID in (select * from table(pi_array))) loop
		update TUYENKENHDEXUAT set DELETED = timeaction_ where ID = rec.ID;
		update TUYENKENH set TRANGTHAI = TRANGTHAI_BAK,SOLUONG = SOLUONG - rec.SOLUONG where ID = rec.TUYENKENH_ID;
    str := '<root><element><id>'||rec.ID||'</id></element></root>';
		PROC_INSERT_LICHSU_TUYENKENH(usercreate_,rec.TUYENKENH_ID,7,str);
	end loop;
END PROC_DELETE_TUYENKENHDEXUAT;

/

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
			insert into SUCOKENH(ID,TUYENKENH_ID,PHULUC_ID,THANHTOAN_ID,THOIDIEMBATDAU,THOIDIEMKETTHUC,THOIGIANMLL,NGUYENNHAN,PHUONGANXULY,NGUOIXACNHAN,GIAMTRUMLL,TRANGTHAI,USERCREATE,TIMECREATE,DELETED,BIENBANVANHANH_ID,LOAISUCO) 
      values (i,rec.TUYENKENH_ID,rec.PHULUC_ID,null,rec.THOIDIEMBATDAU,rec.THOIDIEMKETTHUC,rec.THOIGIANMLL,rec.NGUYENNHAN,rec.PHUONGANXULY,rec.NGUOIXACNHAN,rec.GIAMTRUMLL,0,usercreate_,timecreate_,0,0,rec.LOAISUCO);
    delete from SUCO_IMPORT where ID = rec.ID;
	end loop;
END PROC_IMPORT_SUCO;

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
      UPDATE DOITAC SET SOTUYENKENH = SOTUYENKENH + 1 WHERE ID = rec.DOITAC_ID;
		end if;
    delete from TUYENKENH_IMPORT where ID = rec.ID;
	end loop;
END PROC_IMPORT_TUYENKENH;

/

--------------------------------------------------------
--  DDL for Procedure PROC_INSERT_LICHSU_PHULUC
--------------------------------------------------------
set define off;

  CREATE OR REPLACE PROCEDURE "THUEKENH"."PROC_INSERT_LICHSU_PHULUC" (
useraction_ in varchar2,
phuluc_id_ in varchar2,
action_ in varchar2,
info_ in varchar2
) AS 
BEGIN
	insert into LICHSU_PHULUC(TIMEACTION,USERACTION,INFO,PHULUC_ID,ACTION) values (sysdate,useraction_,info_,phuluc_id_,action_);
END PROC_INSERT_LICHSU_PHULUC;

/

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
--  DDL for Procedure PROC_REMOVE_DOISOATCUOC
--------------------------------------------------------
set define off;

  CREATE OR REPLACE PROCEDURE "THUEKENH"."PROC_REMOVE_DOISOATCUOC" (
doisoatcuoc_id_ in varchar2
) AS 
BEGIN
	delete from DOISOATCUOC where id = doisoatcuoc_id_;
	delete from DOISOATCUOC_PHULUC where DOISOATCUOC_ID = doisoatcuoc_id_;
	delete from DOISOATCUOC_SUCO where DOISOATCUOC_ID = doisoatcuoc_id_;
	commit;
END PROC_REMOVE_DOISOATCUOC;

/

--------------------------------------------------------
--  DDL for Procedure PROC_SAVE_ACCOUNTMENU
--------------------------------------------------------
set define off;

  CREATE OR REPLACE PROCEDURE "THUEKENH"."PROC_SAVE_ACCOUNTMENU" (
pi_array in TABLE_VARCHAR,
pi_id in VARCHAR2
) AS 
i INTEGER := 1;
BEGIN
	delete from USER_MENU where ACCOUNTID = pi_id;
  if(pi_array.COUNT() = 0 ) then 
    return;
  end if;
	LOOP
		INSERT  INTO USER_MENU (ACCOUNTID,MENUID) VALUES(pi_id,pi_array(i));
		EXIT WHEN(i = pi_array.COUNT());
		i := i + 1;
	END LOOP;
END PROC_SAVE_ACCOUNTMENU;

/

--------------------------------------------------------
--  DDL for Procedure PROC_SAVE_CONGTHUC
--------------------------------------------------------
set define off;

  CREATE OR REPLACE PROCEDURE "THUEKENH"."PROC_SAVE_CONGTHUC" (
  id_	in number,
	name_ in VARCHAR2,
  congthuc_ in VARCHAR2,
	usercreate_ in VARCHAR2,
  stt_ IN number,
  deleted_ IN number,
  ma_ in varchar2
) AS 
i INTEGER := 0;
BEGIN
    --i=0 update
      if(id_ is not null and id_>0) then --update
        update CONGTHUC set 
        TENCONGTHUC = name_,
        CHUOICONGTHUC=congthuc_,
        deleted=deleted_,
        stt=STT_,
        ma=ma_
        where ID = id_;
    else --insert
    --i=n insert
      i:=SEQ_CONGTHUC.nextval;
      insert into CONGTHUC(ID,TENCONGTHUC,CHUOICONGTHUC,TIMECREATE,USERCREATE,STT,DELETED,MA)
      VALUES(i,name_,congthuc_,sysdate,usercreate_,stt_,deleted_,ma_);
    end if;

END PROC_SAVE_CONGTHUC;

/

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

--------------------------------------------------------
--  DDL for Procedure PROC_SAVE_DIEMDAUCUOI
--------------------------------------------------------
set define off;

  CREATE OR REPLACE PROCEDURE "THUEKENH"."PROC_SAVE_DIEMDAUCUOI" (
  id_	in nvarchar2,
	name_ in VARCHAR2,
	stt_ IN number,
  deleted_ IN number,
  ma_ in VARCHAR2
) AS 
i INTEGER := 0;
BEGIN
		i:=SEQ_DIEMDAUCUOI.nextval;
		insert into DIEMDAUCUOI(ID,TENDIEMDAUCUOI,DELETED,STT,MA) values (i,name_,deleted_,stt_,ma_);
END PROC_SAVE_DIEMDAUCUOI;

/

--------------------------------------------------------
--  DDL for Procedure PROC_SAVE_DOITAC
--------------------------------------------------------
set define off;

  CREATE OR REPLACE PROCEDURE "THUEKENH"."PROC_SAVE_DOITAC" (
  id_	in nvarchar2,
	name_ in VARCHAR2,
	stt_ IN number,
  deleted_ IN number,
  ma_ in nvarchar2,
  khuvuc_id_ nvarchar2
) AS 
i INTEGER := 0;
BEGIN
		if(id_ is not null and id_>0) then --update
      update DOITAC set TENDOITAC = name_,Ma=ma_ where ID = id_;
	else --insert
		i:=SEQ_DOITAC.nextval;
		insert into DOITAC(ID,TENDOITAC,DELETED,STT,MA,khuvuc_id) values (i,name_,deleted_,stt_,ma_,khuvuc_id_);
  end if;
END PROC_SAVE_DOITAC;

/

--------------------------------------------------------
--  DDL for Procedure PROC_SAVE_DUAN
--------------------------------------------------------
set define off;

  CREATE OR REPLACE PROCEDURE "THUEKENH"."PROC_SAVE_DUAN" (
  id_	in nvarchar2,
	name_ in VARCHAR2,
	stt_ IN number,
  deleted_ IN number,
  mota_ in nvarchar2,
  giamgia_ in number,
  usercreate_ in varchar2,
  ma_ in varchar2
) AS 
i INTEGER := 0;
BEGIN
		i:=SEQ_DUAN.nextval;
		insert into DUAN(ID,TENDUAN,DELETED,STT,MOTA,GIAMGIA,USERCREATE,TIMECREATE,MA) values (i,name_,deleted_,stt_,mota_,giamgia_,usercreate_,sysdate,ma_);
END PROC_SAVE_DUAN;

/

--------------------------------------------------------
--  DDL for Procedure PROC_SAVE_GROUPMENU
--------------------------------------------------------
set define off;

  CREATE OR REPLACE PROCEDURE "THUEKENH"."PROC_SAVE_GROUPMENU" (
pi_array in TABLE_VARCHAR,
pi_id in VARCHAR2
) AS 
i INTEGER := 1;
BEGIN
	delete from GROUP_MENU where IDGROUP = pi_id;
  if(pi_array.COUNT() = 0 ) then 
    return;
  end if;
	LOOP
		INSERT  INTO GROUP_MENU (IDGROUP,IDMENU) VALUES(pi_id,pi_array(i));
		EXIT WHEN(i = pi_array.COUNT());
		i := i + 1;
	END LOOP;
END PROC_SAVE_GROUPMENU;

/

--------------------------------------------------------
--  DDL for Procedure PROC_SAVE_KHUVUC
--------------------------------------------------------
set define off;

  CREATE OR REPLACE PROCEDURE "THUEKENH"."PROC_SAVE_KHUVUC" (
  id_	in nvarchar2,
	name_ in VARCHAR2,
	stt_ IN number,
  deleted_ IN number,
  ma_ in varchar2
) AS 
i INTEGER := 0;
BEGIN
		if(id_ is not null and id_>0) then --update
      update KHUVUC set TENKHUVUC = name_ where ID = id_;
	else --insert
		i:=SEQ_PHONGBAN.nextval;
		insert into KHUVUC(ID,TENKHUVUC,DELETED,STT,MA) values (i,name_,deleted_,stt_,ma_);
  end if;
END PROC_SAVE_KHUVUC;

/

--------------------------------------------------------
--  DDL for Procedure PROC_SAVE_LOAIGIAOTIEP
--------------------------------------------------------
set define off;

  CREATE OR REPLACE PROCEDURE "THUEKENH"."PROC_SAVE_LOAIGIAOTIEP" (
  id_	in number,
	name_ in VARCHAR2,
	cuoccong_ IN number,
  deleted_ IN number,
  ma_ in varchar2,
  stt_ in number
) AS 
i INTEGER := 0;
BEGIN

    --i=0 update
      if(id_ is not null and id_>0) then --update
        update LOAIGIAOTIEP set LOAIGIAOTIEP = name_,CUOCCONG=cuoccong_,Ma=ma_,STT=stt_ where ID = id_;
    else --insert
    --i=n insert
      i:=SEQ_LOAIGIAOTIEP.nextval;
      insert into LOAIGIAOTIEP(ID,LOAIGIAOTIEP,DELETED,CUOCCONG,MA,STT) values (i,name_,deleted_,cuoccong_,ma_,stt_);
    end if;

END PROC_SAVE_LOAIGIAOTIEP;

/

--------------------------------------------------------
--  DDL for Procedure PROC_SAVE_PHONGBAN
--------------------------------------------------------
set define off;

  CREATE OR REPLACE PROCEDURE "THUEKENH"."PROC_SAVE_PHONGBAN" (
  id_	in nvarchar2,
	name_ in VARCHAR2,
	stt_ IN number,
  deleted_ IN number,
  ma_ in VARCHAR2
) AS 
i INTEGER := 0;
BEGIN
		i:=SEQ_PHONGBAN.nextval;
		insert into PHONGBAN(ID,TENPHONGBAN,DELETED,STT,MA) values (i,name_,deleted_,stt_,ma_);
END PROC_SAVE_PHONGBAN;

/

--------------------------------------------------------
--  DDL for Procedure PROC_SAVE_TIEUCHUAN
--------------------------------------------------------
set define off;

  CREATE OR REPLACE PROCEDURE "THUEKENH"."PROC_SAVE_TIEUCHUAN" (
id_ in varchar2,
tentieuchuan_ in varchar2,
loaitieuchuan_ in number,
mota_ in varchar2,
usercreate_ in varchar2,
stt_ in number,
deleted_ in number,
ma_ in varchar2
) AS 
i INTEGER := 0;
BEGIN
    --i=n insert
      i:=SEQ_TIEUCHUAN.nextval;
      insert into TIEUCHUAN(id,tentieuchuan,loaitieuchuan,mota,usercreate,timecreate,stt,deleted,ma) 
      values (i,tentieuchuan_,loaitieuchuan_,mota_,usercreate_,sysdate,stt_,deleted_,ma_);

END PROC_SAVE_TIEUCHUAN;

/

--------------------------------------------------------
--  DDL for Procedure PROC_UPDATE_PLTHAYTHE
--------------------------------------------------------
set define off;

  CREATE OR REPLACE PROCEDURE "THUEKENH"."PROC_UPDATE_PLTHAYTHE" (
arrPhuLucBiThayThe in TABLE_VARCHAR,
phuLucId in varchar2,
tenPhuLuc in varchar2,
ngayHetHieuLuc_ in date,
useraction_ in varchar2
) AS 
BEGIN
  --test(to_char(ngayHetHieuLuc));
	for rec in (select * from PHULUC where DELETED = 0 and ID in (select * from table(arrPhuLucBiThayThe))) loop
		update PHULUC set NGAYHETHIEULUC = ngayHetHieuLuc_,PHULUCTHAYTHE_ID = phuLucId where ID = rec.ID;
		PROC_INSERT_LICHSU_PHULUC(useraction_,rec.ID,4,'<root><element><id>'||phuLucId||'</id><tenphuluc>'||tenPhuLuc||'</tenphuluc></element></root>');
	end loop;
END PROC_UPDATE_PLTHAYTHE;

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
str varchar2(500);
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
	  str := '<root><element><sohoso_id>'||vThanhToanId||'</sohoso_id><sohoso>'||pSoHoSo||'</sohoso><thang>'||i||'</thang><nam>'||vNam||'</nam></element></root>';
	  PROC_INSERT_LICHSU_PHULUC('SYSTEM',rec.ID,6,str);
    str := '<root><element><sohoso_id>'||vThanhToanId||'</sohoso_id><sohoso>'||pSoHoSo||'</sohoso></element></root>';
      for rec2 in (select * from CHITIETPHULUC_TUYENKENH where PHULUC_ID = rec.ID) loop
        
        PROC_INSERT_LICHSU_TUYENKENH('SYSTEM',rec2.TUYENKENH_ID,5,str);
      end loop;
    end loop;
	end if;
  NULL;
END PROC_UPDATE_THANHTOAN;

/

--------------------------------------------------------
--  DDL for Procedure PROC_UPDATE_TIEN_DO
--------------------------------------------------------
set define off;

  CREATE OR REPLACE PROCEDURE "THUEKENH"."PROC_UPDATE_TIEN_DO" (
tuyenkenh_dexuat_id in number,
arr_tieuchuan_id in TABLE_VARCHAR,
username_ in varchar2,
createtime_ in varchar2
)
AS
iTemp number:=0;
iCount number := 0;
tong_tieu_chuan number := 0;
chua_dat number := 0;
iDexuat number;
tiendo_ number;
iTuyenKenhDeXuatChuaBanGiao number;
i number;
tuyenkenh_id_ varchar2(50) := null;
str varchar2(500) := '';
begin
	select TUYENKENH_ID into tuyenkenh_id_  from TUYENKENHDEXUAT where DELETED=0 and ID = tuyenkenh_dexuat_id;
	if(tuyenkenh_id_ is not null) then
		--lay cac tieu chuan da dat dc
		DELETE from TUYENKENH_TIEUCHUAN where TUYENKENHDEXUAT_ID = tuyenkenh_dexuat_id;
		--neu cac tieu chuan ton` tai
		if(arr_tieuchuan_id.count() > 0) then
			for i in arr_tieuchuan_id.first .. arr_tieuchuan_id.last loop
				--them tieu chuan da dat dc
				INSERT INTO TUYENKENH_TIEUCHUAN (TUYENKENHDEXUAT_ID, TIEUCHUAN_ID, USERCREATE, TIMECREATE, DELETED) 
				VALUES (tuyenkenh_dexuat_id, arr_tieuchuan_id(i), username_, createtime_, '0');
				select count(*) into iTemp from tieuchuan where id=arr_tieuchuan_id(i) and loaitieuchuan=1;
				iCount := iCount + iTemp;
				iTemp:=0;
			end loop;
		end if;
		
		select count(*) into tong_tieu_chuan  from tieuchuan where deleted=0 and loaitieuchuan=1;
		select count(*) into chua_dat  from tieuchuan where deleted=0 and loaitieuchuan = 1 and id not in (select * from table(arr_tieuchuan_id));
		if(chua_dat = 0) then
			update tuyenkenhdexuat set TIENDO = 100,trangthai=1 where id=tuyenkenh_dexuat_id;
			select dexuat_id into iDexuat from tuyenkenhdexuat where id=tuyenkenh_dexuat_id and deleted=0;
			if(iDexuat is not null) then
				select count(*) into iTuyenKenhDeXuatChuaBanGiao  from tuyenkenhdexuat where dexuat_id=iDexuat and trangthai!=1 and  deleted=0;
				if(iTuyenKenhDeXuatChuaBanGiao = 0) then
					update dexuat set trangthai=1 where id=iDexuat;
				end if;
			end if;
		else
			if(tong_tieu_chuan = 0) then
				tiendo_ := 0;
				update tuyenkenhdexuat set TIENDO = tiendo_ where id=tuyenkenh_dexuat_id;
			else
				tiendo_ := round(iCount/tong_tieu_chuan*100,2);
			update tuyenkenhdexuat set TIENDO = tiendo_,trangthai=0 where id=tuyenkenh_dexuat_id;
			end if;
		end if;
		
		--update history tuyenkenh
    str := '<root><element><id>'||tuyenkenh_dexuat_id||'</id></element></root>';
		PROC_INSERT_LICHSU_TUYENKENH(username_,tuyenkenh_id_,9,str);
	end if;
end PROC_UPDATE_TIEN_DO;

/

--------------------------------------------------------
--  DDL for Procedure RESET_SEQ
--------------------------------------------------------
set define off;

  CREATE OR REPLACE PROCEDURE "THUEKENH"."RESET_SEQ" ( p_seq_name in varchar2 )
is
    l_val number;
begin
    execute immediate
    'select ' || p_seq_name || '.nextval from dual' INTO l_val;

    execute immediate
    'alter sequence ' || p_seq_name || ' increment by -' || l_val || 
                                                          ' minvalue 0';

    execute immediate
    'select ' || p_seq_name || '.nextval from dual' INTO l_val;

    execute immediate
    'alter sequence ' || p_seq_name || ' increment by 1 minvalue 0';
end;

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
loaisuco_ in NUMBER
) AS
i INTEGER := 0;
BEGIN
    i:=SEQ_SUCOIMPORT.nextval;
    --test(to_char(thoidiembatdau_,'DD-MON-YYYY HH24:MI'));
    insert into SUCO_IMPORT(STT,MADIEMDAU,MADIEMCUOI,DUNGLUONG,MAGIAOTIEP,THOIDIEMBATDAU,THOIDIEMKETTHUC,NGUYENNHAN,PHUONGANXULY,NGUOIXACNHAN,ID,TUYENKENH_ID,PHULUC_ID,THOIGIANMLL,GIAMTRUMLL,LOAISUCO) 
    values (stt_,madiemdau_,madiemcuoi_,dungluong_,magiaotiep_,thoidiembatdau_,thoidiemketthuc_,nguyennhan_,phuonganxuly_,nguoixacnhan_,i,tuyenkenh_id_,phuluc_id_,thoigianmll_,giamtrumll_,loaisuco_);
END SAVE_SUCO_IMPORT;

/

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

--------------------------------------------------------
--  DDL for Function SAVE_BIENBANVANHANH
--------------------------------------------------------

  CREATE OR REPLACE FUNCTION "THUEKENH"."SAVE_BIENBANVANHANH" 
(
  id_ in varchar2,
  sobienban_ in varchar2,
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
    UPDATE BIENBANVANHANH 
    SET 
        SOBIENBAN= sobienban_, 
        DELETED= deleted_,
        FILENAME= filename_,
        FILEPATH= filepath_,
        FILESIZE= filesize_
    WHERE ID= id_;
    i:= id_;
  ELSE -- insert
    i:=SEQ_BIENBANVANHANH.nextval;
    INSERT INTO BIENBANVANHANH(ID,SOBIENBAN,USERCREATE,TIMECREATE,DELETED,FILENAME,FILEPATH,FILESIZE) VALUES (i,sobienban_, usercreate_, timecreate_, 0,filename_, filepath_, filesize_);
  END IF;
  RETURN i;
END SAVE_BIENBANVANHANH;

/

--------------------------------------------------------
--  DDL for Function BC_DOISOATCUOC
--------------------------------------------------------

  CREATE OR REPLACE FUNCTION "THUEKENH"."BC_DOISOATCUOC" (
pDoiSoatCuocId in varchar2
) RETURN SYS_REFCURSOR AS
l_cursor SYS_REFCURSOR;
BEGIN
	OPEN l_cursor FOR select t.*,t1.tenphuluc,t1.soluongkenh,t1.giatritruocthue,t1.hopdong_id,t2.sohopdong from doisoatcuoc_phuluc t left join phuluc t1 on t.phuluc_id = t1.id left join hopdong t2 on t1.hopdong_id = t2.id
	 where t.doisoatcuoc_id = pDoiSoatCuocId order by t1.hopdong_id;
	RETURN l_cursor;
END BC_DOISOATCUOC;

/

--------------------------------------------------------
--  DDL for Function FIND_PHULUC_BITHAYTHE
--------------------------------------------------------

  CREATE OR REPLACE FUNCTION "THUEKENH"."FIND_PHULUC_BITHAYTHE" (phuluc_id_ in varchar2) RETURN varchar2 AS 
v_clob varchar2(2000) := '<root>';
BEGIN
  for rec in (select ID,TENPHULUC from PHULUC where DELETED = 0 and PHULUCTHAYTHE_ID = phuluc_id_) loop
  v_clob := v_clob||'<element><id>'||rec.ID||'</id><tenphuluc>'||rec.TENPHULUC||'</tenphuluc></element>';
  end loop;
  v_clob := v_clob||'</root>';
  RETURN v_clob;
END FIND_PHULUC_BITHAYTHE;

/

--------------------------------------------------------
--  DDL for Function GET_SOTUYENKENH
--------------------------------------------------------

  CREATE OR REPLACE FUNCTION "THUEKENH"."GET_SOTUYENKENH" (doitac_id in number) RETURN NUMBER AS 
rs number;
BEGIN
  select SOTUYENKENH into rs from DOITAC where ID = doitac_id;
  RETURN rs;
END GET_SOTUYENKENH;

/

--------------------------------------------------------
--  DDL for Function FN_FIND_ACCOUNTS
--------------------------------------------------------

  CREATE OR REPLACE FUNCTION "THUEKENH"."FN_FIND_ACCOUNTS" (
iDisplayStart IN NUMBER,   
iDisplayLength IN NUMBER, 
username_ in varchar2,
phongban_ in varchar2,
khuvuc_ in varchar2,
active_ in varchar2
) RETURN SYS_REFCURSOR AS
l_cursor SYS_REFCURSOR;
v_vcsql VARCHAR2(1000);
v_vcsqlwhere VARCHAR2(500);
i NUMBER;
BEGIN
	v_vcsqlwhere := ' 1 = 1 ';
	if(username_ is not null) then
		v_vcsqlwhere := v_vcsqlwhere ||' and USERNAME like '''||username_||'%'' ';
	end if;
	if(phongban_ is not null) then
		v_vcsqlwhere := v_vcsqlwhere ||' and IDPHONGBAN = '||phongban_||' ';
	end if;
	if(khuvuc_ is not null) then
		v_vcsqlwhere := v_vcsqlwhere ||' and IDKHUVUC = '||khuvuc_||' ';
	end if;
	if(active_ is not null) then
		v_vcsqlwhere := v_vcsqlwhere ||' and t0.ACTIVE = '||active_||' ';
	end if;
	v_vcsql := 'select rownum as rn,dulieu.* from (SELECT t0.ID,USERNAME,PASSWORD,IDGROUP,t0.ACTIVE,IDKHUVUC,IDPHONGBAN,TENPHONGBAN,TENKHUVUC,NAMEMENU FROM ACCOUNTS t0 left join PHONGBAN t1 on t0.IDPHONGBAN = t1.ID left join KHUVUC t2 on t0.IDKHUVUC = t2.ID left join MENU t3 on t0.MAINMENU = t3.ID  WHERE ' || v_vcsqlwhere || ' order by ID desc) dulieu ';
	v_vcsql := 'SELECT * FROM (' || v_vcsql || ') WHERE rn > ' || iDisplayStart || ' and rn <= ' || (iDisplayStart+iDisplayLength);
	--dbms_output.put_line(v_vcsql);
 --test(v_vcsql);
	OPEN l_cursor FOR v_vcsql;
	RETURN l_cursor;
END FN_FIND_ACCOUNTS;

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
str varchar2(500) := '';
BEGIN
	--select NGAYHETHAN into ngayhethan_ from HOPDONG where ID = hopdong_id_;
	if(id_ is not null) then --update
		update PHULUC set CHITIETPHULUC_ID = chitietphuluc_id_,HOPDONG_ID = hopdong_id_,TENPHULUC = tenphuluc_,LOAIPHULUC = loaiphuluc_,NGAYKY = ngayky_,NGAYHIEULUC = ngayhieuluc_,FILENAME = filename_,FILEPATH = filepath_,FILESIZE = filesize_,CUOCDAUNOI = cuocdaunoi_,GIATRITRUOCTHUE = giatritruocthue_, GIATRISAUTHUE = giatrisauthue_, SOLUONGKENH = soluongkenh_ where ID = id_;
		i := id_;
		update TUYENKENHDEXUAT set FLAG = 0 where TUYENKENH_ID in (SELECT TUYENKENH_ID FROM CHITIETPHULUC_TUYENKENH where PHULUC_ID = i); -- reset lai nhung TUYENKENHDEXUAT truoc
		update PHULUC set PHULUCTHAYTHE_ID = null,NGAYHETHIEULUC = null where PHULUCTHAYTHE_ID = i;
		update CHITIETPHULUC_TUYENKENH set PHULUC_ID = null where PHULUC_ID = i;
		PROC_INSERT_LICHSU_PHULUC(usercreate_,i,2,'');
	else --insert
		i:=SEQ_PHULUC.nextval;	
		insert into PHULUC(ID,CHITIETPHULUC_ID,HOPDONG_ID,TENPHULUC,LOAIPHULUC,NGAYKY,NGAYHIEULUC,THANG,NAM,TRANGTHAI,USERCREATE,TIMECREATE,DELETED,NGAYHETHIEULUC,FILENAME,FILEPATH,FILESIZE,PHULUCTHAYTHE_ID,CUOCDAUNOI,GIATRITRUOCTHUE,GIATRISAUTHUE,SOLUONGKENH) values (i,chitietphuluc_id_,hopdong_id_,tenphuluc_,loaiphuluc_,ngayky_,ngayhieuluc_,null,null,0,usercreate_,timecreate_,0,null,filename_,filepath_,filesize_,null,cuocdaunoi_,giatritruocthue_,giatrisauthue_,soluongkenh_);
		PROC_INSERT_LICHSU_PHULUC(usercreate_,i,1,'');
	end if;
	update TUYENKENHDEXUAT set FLAG = i where TUYENKENH_ID in (SELECT TUYENKENH_ID FROM CHITIETPHULUC_TUYENKENH where CHITIETPHULUC_ID = chitietphuluc_id_);
	update CHITIETPHULUC_TUYENKENH set PHULUC_ID = i where CHITIETPHULUC_ID = chitietphuluc_id_;
	str := '<root><element><phuluc_id>'||i||'</phuluc_id><tenphuluc>'||tenphuluc_||'</tenphuluc></element></root>';
	for rec in (select * from CHITIETPHULUC_TUYENKENH where CHITIETPHULUC_ID = chitietphuluc_id_) loop
		PROC_INSERT_LICHSU_TUYENKENH(usercreate_,rec.TUYENKENH_ID,4,str);
	end loop;
	return i;
END SAVE_PHULUC;

/

--------------------------------------------------------
--  DDL for Function BC_GIAMTRUMLL
--------------------------------------------------------

  CREATE OR REPLACE FUNCTION "THUEKENH"."BC_GIAMTRUMLL" (
pDoiTacId in varchar2,
pFrom in number,
pEnd in number
) RETURN SYS_REFCURSOR AS
l_cursor SYS_REFCURSOR;
BEGIN
	OPEN l_cursor FOR select t3.*,t.*,loaigiaotiep,t1.giatritruocthue,t1.tenphuluc,t2.sohopdong 
		from sucokenh t left join 
			phuluc t1 on t.phuluc_id = t1.id left join 
			hopdong t2 on t1.hopdong_id = t2.id left join 
			tuyenkenh t3 on t.tuyenkenh_id = t3.id left join 
			loaigiaotiep t4 on t3.giaotiep_id = t4.id 
			where t.phuluc_id is not null and t.thoidiembatdau >= pFrom and t.thoidiembatdau < pEnd and t3.doitac_id = pDoiTacId;
	RETURN l_cursor;
END BC_GIAMTRUMLL;

/

--------------------------------------------------------
--  DDL for Function FIND_DEXUAT
--------------------------------------------------------

  CREATE OR REPLACE FUNCTION "THUEKENH"."FIND_DEXUAT" (
iDisplayStart IN NUMBER,   
iDisplayLength IN NUMBER, 
doitac_id_ in varchar2,
tenvanban_ in varchar2,
ngaygui_ in varchar2,
ngaydenghibangiao_ in varchar2,
trangthai_ in varchar2
) RETURN SYS_REFCURSOR AS
l_cursor SYS_REFCURSOR;
v_vcsql VARCHAR2(2000);
v_vcsqlwhere VARCHAR2(1000);
i NUMBER;
BEGIN
	v_vcsqlwhere := ' t.DELETED = 0 ';
	if(doitac_id_ is not null) then
		v_vcsqlwhere := v_vcsqlwhere ||' and t.DOITAC_ID = '||doitac_id_||' ';
	end if;
	if(trangthai_ is not null) then
		v_vcsqlwhere := v_vcsqlwhere ||' and t.TRANGTHAI = '||trangthai_||' ';
	end if;
	if(tenvanban_ is not null) then
		v_vcsqlwhere := v_vcsqlwhere ||' and t.TENVANBAN like ''%'||tenvanban_||'%'' ';
	end if;
	if(ngaydenghibangiao_ is not null) then
		v_vcsqlwhere := v_vcsqlwhere ||' and t.NGAYDENGHIBANGIAO = TO_DATE('''||ngaydenghibangiao_||''',''DD-MM-RRRR'') ';
	end if;
	if(ngaygui_ is not null) then
		v_vcsqlwhere := v_vcsqlwhere ||' and t.NGAYGUI = TO_DATE('''||ngaygui_||''',''DD-MM-RRRR'') ';
	end if;
	v_vcsql := 'select rownum as rn,dulieu.* from (SELECT t.ID,t.DOITAC_ID,t0.TENDOITAC,TENVANBAN,NGAYGUI,NGAYDENGHIBANGIAO,TRANGTHAI FROM DEXUAT t left join DOITAC t0 on t.DOITAC_ID = t0.ID WHERE ' || v_vcsqlwhere || ' order by t0.ID desc) dulieu ';
	v_vcsql := 'SELECT * FROM (' || v_vcsql || ') WHERE rn > ' || iDisplayStart || ' and rn <= ' || (iDisplayStart+iDisplayLength);
	--dbms_output.put_line(v_vcsql);
 --test(v_vcsql);
	OPEN l_cursor FOR v_vcsql;
	RETURN l_cursor;
END FIND_DEXUAT;

/

--------------------------------------------------------
--  DDL for Function FIND_TUYENKENHDEXUAT
--------------------------------------------------------

  CREATE OR REPLACE FUNCTION "THUEKENH"."FIND_TUYENKENHDEXUAT" (
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
dexuat_id_ in varchar2,
bangiao_id in varchar2
) RETURN SYS_REFCURSOR AS
l_cursor SYS_REFCURSOR;
v_vcsql VARCHAR2(2000);
v_vcsqlwhere VARCHAR2(1000);
i NUMBER;
BEGIN
	v_vcsqlwhere := ' t.DELETED = 0 ';
  if(bangiao_id is not null) then
		v_vcsqlwhere := v_vcsqlwhere ||' and t.BANGIAO_ID = '||bangiao_id||' ';
	end if;
  if(dexuat_id_ is not null) then
		v_vcsqlwhere := v_vcsqlwhere ||' and t.DEXUAT_ID = '||dexuat_id_||' ';
	end if;
	if(makenh_ is not null) then
    v_vcsqlwhere := v_vcsqlwhere ||' and t0.ID like '''||replace(makenh_, '*', '%')||'%'' ';
	end if;
	if(loaigiaotiep_ is not null) then
		v_vcsqlwhere := v_vcsqlwhere ||' and GIAOTIEP_ID = '||loaigiaotiep_||' ';
	end if;
	if(duan_ is not null) then
		v_vcsqlwhere := v_vcsqlwhere ||' and t0.DUAN_ID = '||duan_||' ';
	end if;
	if(doitac_ is not null) then
		v_vcsqlwhere := v_vcsqlwhere ||' and t0.DOITAC_ID = '||doitac_||' ';
	end if;
	if(phongban_ is not null) then
		v_vcsqlwhere := v_vcsqlwhere ||' and t0.PHONGBAN_ID = '||phongban_||' ';
	end if;
	if(trangthai_ is not null) then
		if(trangthai_ = '-1') then -- tim kiem de xuat tuyen kenh chua co bien ban de xuat
			v_vcsqlwhere := v_vcsqlwhere ||' and t.DEXUAT_ID IS NULL  ';
		else
			v_vcsqlwhere := v_vcsqlwhere ||' and t.TRANGTHAI = '||trangthai_||' ';
		end if;
	end if;
	if(madiemdau_ is not null) then
		v_vcsqlwhere := v_vcsqlwhere ||' and t0.MADIEMDAU like '''||replace(madiemdau_, '*', '%')||''' ';
	end if;
	if(madiemcuoi_ is not null) then
		v_vcsqlwhere := v_vcsqlwhere ||' and t0.MADIEMCUOI like '''||replace(madiemcuoi_, '*', '%')||''' ';
	end if;
	if(ngaydenghibangiao_ is not null) then
		v_vcsqlwhere := v_vcsqlwhere ||' and t.NGAYDENGHIBANGIAO = TO_DATE('''||ngaydenghibangiao_||''',''DD-MM-RRRR'') ';
	end if;
	if(ngayhenbangiao_ is not null) then
		v_vcsqlwhere := v_vcsqlwhere ||' and t.NGAYHENBANGIAO = TO_DATE('''||ngayhenbangiao_||''',''DD-MM-RRRR'') ';
	end if;
	v_vcsql := 'select rownum as rn,dulieu.* from (SELECT t.ID as ID,t0.ID as TUYENKENH_ID,MADIEMDAU,MADIEMCUOI,t1.LOAIGIAOTIEP,t0.DUNGLUONG,t.SOLUONG,t2.TENDUAN,t3.TENPHONGBAN,t4.TENDOITAC,t.TRANGTHAI,t.NGAYDENGHIBANGIAO,t.NGAYHENBANGIAO,t0.DOITAC_ID FROM TUYENKENHDEXUAT t left join TUYENKENH t0 on t.TUYENKENH_ID = t0.ID left join LOAIGIAOTIEP t1 on t0.GIAOTIEP_ID = t1.ID left join DUAN t2 on t0.DUAN_ID = t2.ID left join PHONGBAN t3 on t0.PHONGBAN_ID = t3.ID left join DOITAC t4 on t0.DOITAC_ID=t4.ID WHERE ' || v_vcsqlwhere || ' order by t.NGAYDENGHIBANGIAO) dulieu ';
	v_vcsql := 'SELECT * FROM (' || v_vcsql || ') WHERE rn > ' || iDisplayStart || ' and rn <= ' || (iDisplayStart+iDisplayLength);
	--dbms_output.put_line(v_vcsql);
 --test(v_vcsql);
	OPEN l_cursor FOR v_vcsql;
	RETURN l_cursor;
END FIND_TUYENKENHDEXUAT;

/

--------------------------------------------------------
--  DDL for Function FIND_HOSOTHANHTOAN
--------------------------------------------------------

  CREATE OR REPLACE FUNCTION "THUEKENH"."FIND_HOSOTHANHTOAN" (
iDisplayStart IN NUMBER,   
iDisplayLength IN NUMBER, 
sohoso_ in varchar2,
ngaychuyenhosotu_ in varchar2,
ngaychuyenhosoden_ in varchar2,
trangthai_ in varchar2
) RETURN SYS_REFCURSOR AS
l_cursor SYS_REFCURSOR;
v_vcsql VARCHAR2(2000);
v_vcsqlwhere VARCHAR2(1000);
i NUMBER;
BEGIN
	v_vcsqlwhere := ' tt.DELETED =0 ';
	if(sohoso_ is not null) then
		v_vcsqlwhere := v_vcsqlwhere ||' and tt.SOHOSO = '''||sohoso_||''' ';
	end if;
	if(ngaychuyenhosotu_ is not null) then
		v_vcsqlwhere := v_vcsqlwhere ||' and tt.NGAYCHUYENKT >= TO_DATE('''||ngaychuyenhosotu_||''',''DD-MM-RRRR'') ';
	end if;
  if(ngaychuyenhosoden_ is not null) then
		v_vcsqlwhere := v_vcsqlwhere ||' and tt.NGAYCHUYENKT <= TO_DATE('''||ngaychuyenhosoden_||''',''DD-MM-RRRR'') ';
	end if;
  if(trangthai_ is not null) then
		v_vcsqlwhere := v_vcsqlwhere ||' and tt.TRANGTHAI = '||trangthai_||' ';
	end if;
	v_vcsql := 'select rownum as rn,dulieu.* from (SELECT tt.*,dsc.thanhtien giatritt,dsc.giamtrumll,extract(month from dsc.DENNGAY) as thang,extract(year from dsc.DENNGAY) as nam
                                                 FROM THANHTOAN tt INNER JOIN DOISOATCUOC dsc ON tt.DOISOATCUOC_ID=dsc.ID 
                                                 WHERE ' || v_vcsqlwhere || ' order by tt.TIMECREATE desc) dulieu ';
	v_vcsql := 'SELECT * FROM (' || v_vcsql || ') WHERE rn > ' || iDisplayStart || ' and rn <= ' || (iDisplayStart+iDisplayLength);
	dbms_output.put_line(v_vcsql);
 --test(v_vcsql);
	OPEN l_cursor FOR v_vcsql;
	RETURN l_cursor;
END FIND_HOSOTHANHTOAN;

/

--------------------------------------------------------
--  DDL for Function FN_FIND_HOPDONGBY_THANHTOAN
--------------------------------------------------------

  CREATE OR REPLACE FUNCTION "THUEKENH"."FN_FIND_HOPDONGBY_THANHTOAN" 
(
  thanhtoan_id_ in varchar2
) 
RETURN SYS_REFCURSOR AS l_cursor SYS_REFCURSOR;
v_vcsql VARCHAR2(2000);
i NUMBER;
BEGIN
	v_vcsql := 'select rownum as rn,dulieu.* from (SELECT DISTINCT hd.*,dt.TENDOITAC
                                                 FROM THANHTOAN_PHULUC tp INNER JOIN PHULUC p ON tp.PHULUC_ID=p.ID 
                                                 INNER JOIN HOPDONG hd ON hd.ID=p.HOPDONG_ID 
                                                 INNER JOIN DOITAC dt ON hd.DOITAC_ID=dt.ID
                                                 WHERE tp.THANHTOAN_ID=' || thanhtoan_id_ || ') dulieu ';
	OPEN l_cursor FOR v_vcsql;
	RETURN l_cursor;
END FN_FIND_HOPDONGBY_THANHTOAN;

/

--------------------------------------------------------
--  DDL for Function FIND_PHULUC_BY_HD_DSC
--------------------------------------------------------

  CREATE OR REPLACE FUNCTION "THUEKENH"."FIND_PHULUC_BY_HD_DSC" (
iDisplayStart IN NUMBER,   
iDisplayLength IN NUMBER, 
doisoatcuoc_id_ in varchar2,
hopdong_id_ in varchar2
) RETURN SYS_REFCURSOR AS
l_cursor SYS_REFCURSOR;
v_vcsql VARCHAR2(2000);
v_vcsqlwhere VARCHAR2(1000);
i NUMBER;
BEGIN
	v_vcsqlwhere := ' t.DELETED = 0 ';
	if(doisoatcuoc_id_ is not null) then
		v_vcsqlwhere := v_vcsqlwhere ||' and dp.DOISOATCUOC_ID = '||doisoatcuoc_id_||' ';
	end if;
	if(hopdong_id_ is not null) then
		v_vcsqlwhere := v_vcsqlwhere ||' and t.HOPDONG_ID = '||hopdong_id_||' ';
	end if;
	v_vcsql := 'select rownum as rn,dulieu.* from (SELECT t.*,t0.SOHOPDONG,t0.LOAIHOPDONG,t0.DOITAC_ID,t2.TENDOITAC,FIND_PHULUC_BITHAYTHE(t.ID) as PHULUCBITHAYTHE FROM PHULUC t 
		left join HOPDONG t0 on t.HOPDONG_ID = t0.ID 
    left join DOISOATCUOC_PHULUC dp on dp.PHULUC_ID=t.ID
		left join DOITAC t2 on t0.DOITAC_ID = t2.ID  WHERE ' || v_vcsqlwhere || ' order by t.ID desc) dulieu ';
	v_vcsql := 'SELECT * FROM (' || v_vcsql || ') WHERE rn > ' || iDisplayStart || ' and rn <= ' || (iDisplayStart+iDisplayLength);
	--dbms_output.put_line(v_vcsql);
--test(v_vcsql);
	OPEN l_cursor FOR v_vcsql;
	RETURN l_cursor;
END FIND_PHULUC_BY_HD_DSC;

/

--------------------------------------------------------
--  DDL for Function FIND_DOISOATCUOC
--------------------------------------------------------

  CREATE OR REPLACE FUNCTION "THUEKENH"."FIND_DOISOATCUOC" (
iDisplayStart IN NUMBER,   
iDisplayLength IN NUMBER, 
id_ in varchar2,
tenbangdoisoatcuoc_ in varchar2
) RETURN SYS_REFCURSOR AS
l_cursor SYS_REFCURSOR;
v_vcsql VARCHAR2(2000);
v_vcsqlwhere VARCHAR2(1000);
i NUMBER;
BEGIN
	v_vcsqlwhere := ' t.DELETED = 0 ';
  if(id_ is not null) then
		v_vcsqlwhere := v_vcsqlwhere ||' and t.ID = '||id_||' ';
  end if;
	if(tenbangdoisoatcuoc_ is not null) then
		v_vcsqlwhere := v_vcsqlwhere ||' and t.TENDOISOATCUOC like ''%'||tenbangdoisoatcuoc_||'%'' ';
	end if;
	v_vcsql := 'select rownum as rn,dulieu.* from (SELECT t.* FROM DOISOATCUOC t WHERE ' || v_vcsqlwhere || ' order by t.ID desc) dulieu ';
	v_vcsql := 'SELECT * FROM (' || v_vcsql || ') WHERE rn > ' || iDisplayStart || ' and rn <= ' || (iDisplayStart+iDisplayLength);
	--dbms_output.put_line(v_vcsql);
 --test(v_vcsql);
	OPEN l_cursor FOR v_vcsql;
	RETURN l_cursor;
END FIND_DOISOATCUOC;

/

--------------------------------------------------------
--  DDL for Function GET_MENU_BY_GROUP
--------------------------------------------------------

  CREATE OR REPLACE FUNCTION "THUEKENH"."GET_MENU_BY_GROUP" (
groupid_ in varchar2
) RETURN SYS_REFCURSOR AS
l_cursor SYS_REFCURSOR;
i NUMBER;
BEGIN
	OPEN l_cursor FOR select t1.* from GROUP_MENU t0 left join MENU t1 on t0.IDMENU = t1.ID where IDGROUP = groupid_;
	RETURN l_cursor;
END GET_MENU_BY_GROUP;

/

--------------------------------------------------------
--  DDL for Function FN_FIND_BIENBANVANHANHKENH
--------------------------------------------------------

  CREATE OR REPLACE FUNCTION "THUEKENH"."FN_FIND_BIENBANVANHANHKENH" 
(
  iDisplayStart IN NUMBER,   
  iDisplayLength IN NUMBER, 
  sobienban_ in varchar2
) 
RETURN SYS_REFCURSOR AS l_cursor SYS_REFCURSOR;
v_vcsql VARCHAR2(2000);
v_vcsqlwhere VARCHAR2(1000);
i NUMBER;
BEGIN
	v_vcsqlwhere := ' DELETED = 0 ';
	if(sobienban_ is not null) then
		v_vcsqlwhere := v_vcsqlwhere ||' AND SOBIENBAN = '''||sobienban_||''' ';
	end if;
	v_vcsql := 'select rownum as rn,dulieu.* from (SELECT *
                                                 FROM BIENBANVANHANH   
                                                 WHERE ' || v_vcsqlwhere || ' ORDER BY TIMECREATE desc) dulieu ';
	v_vcsql := 'SELECT * FROM (' || v_vcsql || ') WHERE rn > ' || iDisplayStart || ' and rn <= ' || (iDisplayStart+iDisplayLength);
	--dbms_output.put_line(v_vcsql);
  --test(v_vcsql);
	OPEN l_cursor FOR v_vcsql;
	RETURN l_cursor;
END FN_FIND_BIENBANVANHANHKENH;

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

--------------------------------------------------------
--  DDL for Function BC_HDCHUATHANHTOAN
--------------------------------------------------------

  CREATE OR REPLACE FUNCTION "THUEKENH"."BC_HDCHUATHANHTOAN" (
pDoiTacId in varchar2,
pPrevious in date,
pCurrent in date
) RETURN SYS_REFCURSOR AS
l_cursor SYS_REFCURSOR;
v_vcsql VARCHAR2(2000);
v_vcsqlwhere VARCHAR2(1000);
vThang number;
vNam number;
BEGIN
	vThang := extract(month from pPrevious);
	vNam := extract(year from pPrevious);
	OPEN l_cursor FOR select t.*,sohopdong as tenhopdong from PHULUC t left join HOPDONG t1 on t.hopdong_id = t1.id 
where t1.deleted =0 and t.deleted = 0 and t.trangthai != 1 and (t.thang is null or t.thang < vThang) and (t.nam is null or t.nam = vNam) and (pDoiTacId is null or t1.doitac_id = pDoiTacId) and t.ngayhieuluc < pCurrent;
	RETURN l_cursor;
END BC_HDCHUATHANHTOAN;

/

--------------------------------------------------------
--  DDL for Function SAVE_CHITIETPHULUC
--------------------------------------------------------

  CREATE OR REPLACE FUNCTION "THUEKENH"."SAVE_CHITIETPHULUC" (
id_ in VARCHAR2,
tenchitietphuluc_ in VARCHAR2,
cuocdaunoi_ in VARCHAR2,
giatritruocthue_ in VARCHAR2,
giatrisauthue_ in VARCHAR2,
usercreate_ in VARCHAR2,
timecreate_ in VARCHAR2,
soluongkenh_ in VARCHAR2
) RETURN NUMBER AS
i INTEGER := 0;
BEGIN
	if(id_ is not null) then --update
		update CHITIETPHULUC set TENCHITIETPHULUC = tenchitietphuluc_,CUOCDAUNOI = cuocdaunoi_,GIATRITRUOCTHUE = giatritruocthue_,GIATRISAUTHUE = giatrisauthue_,SOLUONGKENH = soluongkenh_ where ID = id_;
		i := id_;
	else --insert
		i:=SEQ_CHITIETPHULUC.nextval;
		
		insert into CHITIETPHULUC(ID,TENCHITIETPHULUC,CUOCDAUNOI,GIATRITRUOCTHUE,GIATRISAUTHUE,USERCREATE,TIMECREATE,DELETED,SOLUONGKENH) values (i,tenchitietphuluc_,cuocdaunoi_,giatritruocthue_,giatrisauthue_,usercreate_,timecreate_,0,soluongkenh_);
	end if;
	insert into CHITIETPHULUC_TUYENKENH(CHITIETPHULUC_ID,TUYENKENH_ID,CONGTHUC_ID,SOLUONG,CUOCCONG,CUOCDAUNOI,DONGIA,GIAMGIA,THANHTIEN) select i,TUYENKENH_ID,CONGTHUC_ID,SOLUONG,CUOCCONG,CUOCDAUNOI,DONGIA,GIAMGIA,THANHTIEN from CHITIETPHULUC_TUYENKENH_TMP;
	return i;
END SAVE_CHITIETPHULUC;

/

--------------------------------------------------------
--  DDL for Function FN_FIND_SUCO_BY_THANHTOAN
--------------------------------------------------------

  CREATE OR REPLACE FUNCTION "THUEKENH"."FN_FIND_SUCO_BY_THANHTOAN" 
(
  thanhtoan_id_ in varchar2
) 
RETURN SYS_REFCURSOR AS l_cursor SYS_REFCURSOR;
v_vcsql VARCHAR2(2000);
v_vcsqlwhere VARCHAR2(1000);
i NUMBER;
BEGIN
	v_vcsqlwhere := ' DELETED = 0 ';
  if(thanhtoan_id_ is not null) then
		v_vcsqlwhere := v_vcsqlwhere ||' and THANHTOAN_ID='||thanhtoan_id_||' ';
	end if;
	v_vcsql := 'select rownum as rn,dulieu.* from (SELECT *
                                                 FROM SUCOKENH 
                                                 WHERE ' || v_vcsqlwhere || ') dulieu ';
	v_vcsql := 'SELECT * FROM (' || v_vcsql || ')';
	--dbms_output.put_line(v_vcsql);
  --test(v_vcsql);
	OPEN l_cursor FOR v_vcsql;
	RETURN l_cursor;
END FN_FIND_SUCO_BY_THANHTOAN;

/

--------------------------------------------------------
--  DDL for Function FN_FIND_TUYENKENHSUCO
--------------------------------------------------------

  CREATE OR REPLACE FUNCTION "THUEKENH"."FN_FIND_TUYENKENHSUCO" (
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
  else
    v_vcsqlwhere := v_vcsqlwhere ||' and TRANGTHAI <> 0 ';
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
END FN_FIND_TUYENKENHSUCO;

/

--------------------------------------------------------
--  DDL for Function FIND_PHULUC_BY_HD_TT
--------------------------------------------------------

  CREATE OR REPLACE FUNCTION "THUEKENH"."FIND_PHULUC_BY_HD_TT" (
iDisplayStart IN NUMBER,   
iDisplayLength IN NUMBER, 
thanhtoan_id_ in varchar2,
hopdong_id_ in varchar2
) RETURN SYS_REFCURSOR AS
l_cursor SYS_REFCURSOR;
v_vcsql VARCHAR2(2000);
v_vcsqlwhere VARCHAR2(1000);
i NUMBER;
BEGIN
	v_vcsqlwhere := ' t.DELETED = 0 ';
	if(thanhtoan_id_ is not null) then
		v_vcsqlwhere := v_vcsqlwhere ||' and tp.THANHTOAN_ID = '||thanhtoan_id_||' ';
	end if;
	if(hopdong_id_ is not null) then
		v_vcsqlwhere := v_vcsqlwhere ||' and t.HOPDONG_ID = '||hopdong_id_||' ';
	end if;
	v_vcsql := 'select rownum as rn,dulieu.* from (SELECT t.*,t0.SOHOPDONG,t0.LOAIHOPDONG,t0.DOITAC_ID,t2.TENDOITAC,FIND_PHULUC_BITHAYTHE(t.ID) as PHULUCBITHAYTHE FROM PHULUC t 
		left join HOPDONG t0 on t.HOPDONG_ID = t0.ID 
    left join THANHTOAN_PHULUC tp on tp.PHULUC_ID=t.ID
		left join DOITAC t2 on t0.DOITAC_ID = t2.ID  WHERE ' || v_vcsqlwhere || ' order by t.ID desc) dulieu ';
	v_vcsql := 'SELECT * FROM (' || v_vcsql || ') WHERE rn > ' || iDisplayStart || ' and rn <= ' || (iDisplayStart+iDisplayLength);
	--dbms_output.put_line(v_vcsql);
--test(v_vcsql);
	OPEN l_cursor FOR v_vcsql;
	RETURN l_cursor;
END FIND_PHULUC_BY_HD_TT;

/

--------------------------------------------------------
--  DDL for Function BC_CHUAHOPDONG
--------------------------------------------------------

  CREATE OR REPLACE FUNCTION "THUEKENH"."BC_CHUAHOPDONG" (
doitac_id_ in varchar2
) RETURN SYS_REFCURSOR AS
/*
Bao cao doi tac da ban giao kenh nhung chua co hop dong
*/
l_cursor SYS_REFCURSOR;
v_vcsql VARCHAR2(2000);
v_vcsqlwhere VARCHAR2(1000);
BEGIN
	v_vcsqlwhere := ' t.DELETED = 0 and t.BANGIAO_ID is not null and t.FLAG = 0 ';
	if(doitac_id_ is not null) then
		v_vcsqlwhere := v_vcsqlwhere ||' and t1.DOITAC_ID = '||doitac_id_||' ';
	end if;
	v_vcsql := 'select t1.*,t4.LOAIGIAOTIEP,t.NGAYDENGHIBANGIAO,t.NGAYHENBANGIAO,t.SOLUONG as SOLUONGDEXUAT,t2.SOBIENBAN,t2.NGAYBANGIAO,t3.TENDOITAC from TUYENKENHDEXUAT t left join TUYENKENH t1 on t.TUYENKENH_ID = t1.ID left join BANGIAO t2 on t2.ID = t.BANGIAO_ID left join DOITAC t3 on t1.DOITAC_ID = t3.ID left join LOAIGIAOTIEP t4 on t1.GIAOTIEP_ID = t4.ID WHERE ' || v_vcsqlwhere || ' order by t.ID desc';
	OPEN l_cursor FOR v_vcsql;
	RETURN l_cursor;
END BC_CHUAHOPDONG;

/

--------------------------------------------------------
--  DDL for Function SAVE_DEXUAT
--------------------------------------------------------

  CREATE OR REPLACE FUNCTION "THUEKENH"."SAVE_DEXUAT" (
id_ in VARCHAR2,
doitac_id_ in VARCHAR2,
filename_ in VARCHAR2,
tenvanban_ in VARCHAR2,
ngaygui_ in VARCHAR2,
ngaydenghibangiao_ in VARCHAR2,
thongtinthem_ in VARCHAR2,
usercreate_ in VARCHAR2,
timecreate_ in VARCHAR2,
trangthai_ in VARCHAR2,
filepath_ in VARCHAR2,
filesize_ in VARCHAR2
) RETURN NUMBER AS
i INTEGER := 0;
BEGIN
	if(id_ is not null and id_>0) then --update
		update DEXUAT set DOITAC_ID = doitac_id_,FILENAME = filename_,FILEPATH = filepath_,FILESIZE = filesize_,TENVANBAN = tenvanban_,NGAYGUI = ngaygui_,NGAYDENGHIBANGIAO = ngaydenghibangiao_,THONGTINTHEM = thongtinthem_,TRANGTHAI = trangthai_ where ID = id_;
		update TUYENKENHDEXUAT set DEXUAT_ID = null where DEXUAT_ID = id_;
		i := id_;
	else --insert
		i:=SEQ_DEXUAT.nextval;
		
		insert into DEXUAT(ID, DOITAC_ID, TENVANBAN, NGAYGUI, NGAYDENGHIBANGIAO, THONGTINTHEM, HISTORY, USERCREATE, TIMECREATE, DELETED, TRANGTHAI,FILENAME,FILEPATH,FILESIZE) values (i, doitac_id_, tenvanban_, ngaygui_, ngaydenghibangiao_, thongtinthem_, '', usercreate_, timecreate_, 0, trangthai_,filename_,filepath_,filesize_);
	end if;
	return i;
END SAVE_DEXUAT;

/

--------------------------------------------------------
--  DDL for Function FIND_HOPDONG
--------------------------------------------------------

  CREATE OR REPLACE FUNCTION "THUEKENH"."FIND_HOPDONG" (
iDisplayStart IN NUMBER,   
iDisplayLength IN NUMBER, 
doitac_id_ in varchar2,
sohopdong_ in varchar2,
loaihopdong_ in varchar2,
ngaykytu_ in varchar2,
ngaykyden_ in varchar2,
ngayhethantu_ in varchar2,
ngayhethanden_ in varchar2
) RETURN SYS_REFCURSOR AS
l_cursor SYS_REFCURSOR;
v_vcsql VARCHAR2(2000);
v_vcsqlwhere VARCHAR2(1000);
i NUMBER;
BEGIN
	v_vcsqlwhere := ' t.DELETED = 0 ';
	if(doitac_id_ is not null) then
		v_vcsqlwhere := v_vcsqlwhere ||' and t.DOITAC_ID = '||doitac_id_||' ';
	end if;
	if(sohopdong_ is not null) then
		v_vcsqlwhere := v_vcsqlwhere ||' and t.SOHOPDONG like ''%'||sohopdong_||'%'' ';
	end if;
	if(loaihopdong_ is not null) then
		v_vcsqlwhere := v_vcsqlwhere ||' and t.LOAIHOPDONG = '||loaihopdong_||' ';
	end if;
	if(ngaykytu_ is not null) then
		v_vcsqlwhere := v_vcsqlwhere ||' and t.NGAYKY >= TO_DATE('''||ngaykytu_||''',''DD-MM-RRRR'') ';
	end if;
  if(ngaykyden_ is not null) then
		v_vcsqlwhere := v_vcsqlwhere ||' and t.NGAYKY <= TO_DATE('''||ngaykyden_||''',''DD-MM-RRRR'') ';
	end if;
	if(ngayhethantu_ is not null) then
		v_vcsqlwhere := v_vcsqlwhere ||' and t.NGAYHETHAN >= TO_DATE('''||ngayhethantu_||''',''DD-MM-RRRR'') ';
	end if;
  if(ngayhethanden_ is not null) then
		v_vcsqlwhere := v_vcsqlwhere ||' and t.NGAYHETHAN <= TO_DATE('''||ngayhethanden_||''',''DD-MM-RRRR'') ';
	end if;
	v_vcsql := 'select rownum as rn,dulieu.* from (SELECT t.*,t0.TENDOITAC FROM HOPDONG t left join DOITAC t0 on t.DOITAC_ID = t0.ID WHERE ' || v_vcsqlwhere || ' order by t.ID desc) dulieu ';
	v_vcsql := 'SELECT * FROM (' || v_vcsql || ') WHERE rn > ' || iDisplayStart || ' and rn <= ' || (iDisplayStart+iDisplayLength);
	--dbms_output.put_line(v_vcsql);
 --test(v_vcsql);
	OPEN l_cursor FOR v_vcsql;
	RETURN l_cursor;
END FIND_HOPDONG;

/

--------------------------------------------------------
--  DDL for Function SAVE_TRAM
--------------------------------------------------------

  CREATE OR REPLACE FUNCTION "THUEKENH"."SAVE_TRAM" (
id_ in VARCHAR2,
matram_ in VARCHAR2,
diachi_ in VARCHAR2
) RETURN NUMBER AS
i INTEGER := 0;
BEGIN
	if(id_ is not null and id_>0) then --update
		update TRAM set MATRAM = matram_, DIACHI = diachi_ where ID = id_;
		i := id_;
	else --insert
		i:= SEQ_TRAM.nextval;
		insert into TRAM(ID, MATRAM, DIACHI, DELETED) values (i, matram_, diachi_, 0);
	end if;
	return i;
END SAVE_TRAM;

/

--------------------------------------------------------
--  DDL for Function FIND_PHULUC_HIEULUC
--------------------------------------------------------

  CREATE OR REPLACE FUNCTION "THUEKENH"."FIND_PHULUC_HIEULUC" (
tuyenkenh_id_ in varchar2,
date_ in date
) RETURN SYS_REFCURSOR AS
l_cursor SYS_REFCURSOR;
BEGIN
	OPEN l_cursor FOR select t.* from phuluc t left join chitietphuluc_tuyenkenh t1 on t.id = t1.phuluc_id
where t.deleted = 0 and t1.tuyenkenh_id = tuyenkenh_id_ and ( (t.ngayhethieuluc is null and t.ngayhieuluc  < date_ + 1 ) or (t.ngayhethieuluc is not null and t.ngayhethieuluc >= date_ and t.ngayhieuluc < date_ + 1 ) );
	RETURN l_cursor;
END FIND_PHULUC_HIEULUC;

/

--------------------------------------------------------
--  DDL for Function GETLISTMENU
--------------------------------------------------------

  CREATE OR REPLACE FUNCTION "THUEKENH"."GETLISTMENU" (
idaccount_ in number,
idgroup_ in varchar2
) RETURN CLOB AS 
----========================================================================
-- @project: VMS quan ly kenh truyen dan
-- @description: Lay danh sach menu cua user, tra ve dang chuoi HTML
-- @author	nclong
-- @date Feb 16, 2012
-- @param
-- @vesion 1.0
-- @copyright nclong
---- @date update 
---- @user update
---- @note: 
----========================================================================
TYPE table_menu_bulk IS TABLE OF MENU%ROWTYPE;
tableMenu table_menu_bulk := table_menu_bulk();
vc_sql varchar2(2000);
clob_return clob;
vc_tmp varchar2(4000);
num number;
BEGIN
	clob_return := '<ul class="sf-menu">';
	vc_sql:= 'select m.* from menu m,user_menu u where m.active = 1 and m.id=u.menuid and accountid='||idaccount_||' union select t3.* from group_menu t1,vmsgroup t2,menu t3 where t3.active = 1 and t1.idmenu=t3.id and t1.idgroup=t2.id  and t2.active=1 and t2.id='''||idgroup_||''' ';
	EXECUTE IMMEDIATE vc_sql BULK COLLECT INTO tableMenu ; 
  if(tableMenu.count()>0) then
	for rec in (select ID,NAME from ROOTMENU) loop
		vc_tmp := null;
    num := 0;
		for n in tableMenu.first .. tableMenu.last loop
			if(rec.ID = tableMenu(n).IDROOTMENU) then
				--DBMS_LOB.append (clob_return,'<li>');
				vc_tmp := vc_tmp||'<li><a href="#" onclick="loadContent('''||tableMenu(n).ACTION||''')">'||tableMenu(n).NAMEMENU||'</a></li>';
        num := num + 1;
      end if;
			--DBMS_OUTPUT.PUT_LINE(tableMenu(n).NAMEMENU);
		end loop;
		
		if(num > 1) then 
			vc_tmp := '<li><a href="#a">'||rec.NAME||'</a><ul>'||vc_tmp||'</ul></li>';
			DBMS_LOB.append (clob_return,vc_tmp);
    elsif (num = 1) then
      DBMS_LOB.append (clob_return,vc_tmp);
		end if;
	end loop;
  end if;
	DBMS_LOB.append (clob_return,'</ul>');
	--DBMS_OUTPUT.PUT_LINE(clob_return);
	RETURN clob_return;
END GETLISTMENU;

/

--------------------------------------------------------
--  DDL for Function SAVE_HOPDONG
--------------------------------------------------------

  CREATE OR REPLACE FUNCTION "THUEKENH"."SAVE_HOPDONG" (
id_ in VARCHAR2,
doitac_id_ in VARCHAR2,
sohopdong_ in VARCHAR2,
loaihopdong_ in VARCHAR2,
ngayky_ in VARCHAR2,
ngayhethan_ in VARCHAR2,
usercreate_ in VARCHAR2,
timecreate_ in VARCHAR2,
history_ in VARCHAR2
) RETURN NUMBER AS
i INTEGER := 0;
BEGIN
	if(id_ is not null) then --update
		update HOPDONG set DOITAC_ID = doitac_id_,SOHOPDONG = sohopdong_,LOAIHOPDONG = loaihopdong_,NGAYKY = ngayky_,NGAYHETHAN = ngayhethan_,HISTORY = history_ where ID = id_;
		i := id_;
	else --insert
		i:=SEQ_HOPDONG.nextval;
		
		insert into HOPDONG(ID,DOITAC_ID,SOHOPDONG,LOAIHOPDONG,NGAYKY,NGAYHETHAN,TRANGTHAI,USERCREATE,TIMECREATE,HISTORY,DELETED) values (i, doitac_id_, sohopdong_, loaihopdong_, ngayky_, ngayhethan_,0, usercreate_, timecreate_, history_,0);
	end if;
	return i;
END SAVE_HOPDONG;

/

--------------------------------------------------------
--  DDL for Function SAVE_THANHTOAN_PHUCLUC
--------------------------------------------------------

  CREATE OR REPLACE FUNCTION "THUEKENH"."SAVE_THANHTOAN_PHUCLUC" 
(
  thanhtoan_id_ in varchar2,
  phuluc_id_ in varchar2
)
RETURN NUMBER AS i INTEGER :=0; 
BEGIN
    INSERT INTO THANHTOAN_PHULUC(THANHTOAN_ID,PHULUC_ID) VALUES (thanhtoan_id_,phuluc_id_);
END SAVE_THANHTOAN_PHUCLUC;

/

--------------------------------------------------------
--  DDL for Function FN_FIND_SUCO_BY_BIENBANVANHANH
--------------------------------------------------------

  CREATE OR REPLACE FUNCTION "THUEKENH"."FN_FIND_SUCO_BY_BIENBANVANHANH" 
(
  bienbanvanhanh_id_ in varchar2
) 
RETURN SYS_REFCURSOR AS l_cursor SYS_REFCURSOR;
v_vcsql VARCHAR2(2000);
v_vcsqlwhere VARCHAR2(1000);
i NUMBER;
BEGIN
	v_vcsqlwhere := ' DELETED = 0 ';
  if(bienbanvanhanh_id_ is not null) then
		v_vcsqlwhere := v_vcsqlwhere ||' and BIENBANVANHANH_ID='||bienbanvanhanh_id_||' ';
	end if;
	v_vcsql := 'select rownum as rn,dulieu.* from (SELECT *
                                                 FROM SUCOKENH 
                                                 WHERE ' || v_vcsqlwhere || ') dulieu ';
	v_vcsql := 'SELECT * FROM (' || v_vcsql || ')';
	--dbms_output.put_line(v_vcsql);
  --test(v_vcsql);
	OPEN l_cursor FOR v_vcsql;
	RETURN l_cursor;
END FN_FIND_SUCO_BY_BIENBANVANHANH;

/

--------------------------------------------------------
--  DDL for Function FIND_TRAM
--------------------------------------------------------

  CREATE OR REPLACE FUNCTION "THUEKENH"."FIND_TRAM" (
iDisplayStart IN NUMBER,   
iDisplayLength IN NUMBER, 
matram_ in varchar2,
diachi_ in varchar2
) RETURN SYS_REFCURSOR AS
l_cursor SYS_REFCURSOR;
v_vcsql VARCHAR2(2000);
v_vcsqlwhere VARCHAR2(1000);
i NUMBER;
BEGIN
	v_vcsqlwhere := ' t.DELETED = 0 ';
	if(matram_ is not null) then
		v_vcsqlwhere := v_vcsqlwhere ||' and t.MATRAM like '''||replace(matram_, '*', '%')||'%'' ';
	end if;
	if(diachi_ is not null) then
		v_vcsqlwhere := v_vcsqlwhere ||' and t.DIACHI like '''||replace(diachi_, '*', '%')||'%'' ';
	end if;
	v_vcsql := 'select rownum as rn,dulieu.* from (SELECT t.* FROM TRAM t WHERE ' || v_vcsqlwhere || ' order by t.ID desc) dulieu ';
	v_vcsql := 'SELECT * FROM (' || v_vcsql || ') WHERE rn > ' || iDisplayStart || ' and rn <= ' || (iDisplayStart+iDisplayLength);
	--dbms_output.put_line(v_vcsql);
 --test(v_vcsql);
	OPEN l_cursor FOR v_vcsql;
	RETURN l_cursor;
END FIND_TRAM;

/

--------------------------------------------------------
--  DDL for Function FN_FIND_PHULUCBY_DSCUOC_HD
--------------------------------------------------------

  CREATE OR REPLACE FUNCTION "THUEKENH"."FN_FIND_PHULUCBY_DSCUOC_HD" 
(
  doisoatcuoc_id_ in varchar2,
  hopdong_id_ in varchar2
) 
RETURN SYS_REFCURSOR AS l_cursor SYS_REFCURSOR;
v_vcsql VARCHAR2(2000);
i NUMBER;
BEGIN
	v_vcsql := 'select rownum as rn,dulieu.* from (SELECT tp.PHULUC_ID
                                                 FROM DOISOATCUOC_PHULUC tp INNER JOIN PHULUC p ON tp.PHULUC_ID=p.ID   
                                                 WHERE tp.DOISOATCUOC_ID=' || doisoatcuoc_id_ || ' AND p.HOPDONG_ID=' || hopdong_id_ || ') dulieu ';
	OPEN l_cursor FOR v_vcsql;
	RETURN l_cursor;
END FN_FIND_PHULUCBY_DSCUOC_HD;

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
	v_vcsql := 'select t1.*,t3.LOAIGIAOTIEP,t.NGAYDENGHIBANGIAO,t.NGAYHENBANGIAO,t.SOLUONG as SOLUONGDEXUAT,t.TIENDO,TENDOITAC from TUYENKENHDEXUAT t left join TUYENKENH t1 on t.TUYENKENH_ID = t1.ID left join DOITAC t2 on t1.DOITAC_ID = t2.ID left join LOAIGIAOTIEP t3 on t1.GIAOTIEP_ID = t3.ID WHERE ' || v_vcsqlwhere || ' order by t.ID desc';
	OPEN l_cursor FOR v_vcsql;
	RETURN l_cursor;
END BC_CHUABANGIAO;

/

--------------------------------------------------------
--  DDL for Function SAVE_ACCOUNT
--------------------------------------------------------

  CREATE OR REPLACE FUNCTION "THUEKENH"."SAVE_ACCOUNT" 
(
	id_	in VARCHAR2,
	username_ in VARCHAR2,
	password_ in VARCHAR2,
	active_ in NUMBER,
	idkhuvuc_ in NUMBER,
	idphongban_ in NUMBER,
  idgroup_ in varchar2,
  mainmenu_ in varchar2
)
RETURN NUMBER AS
n NUMBER;
BEGIN
	if(id_ is not null) then --update
    if(password_ is not null) then
      update ACCOUNTS set IDGROUP = idgroup_, PASSWORD = password_, ACTIVE = active_, IDKHUVUC = idkhuvuc_, IDPHONGBAN = idphongban_, MAINMENU = mainmenu_ where ID = to_number(id_);
    else
      update ACCOUNTS set IDGROUP = idgroup_, ACTIVE = active_, IDKHUVUC = idkhuvuc_, IDPHONGBAN = idphongban_ where ID = to_number(id_);
    end if;
	else --insert
		n := SEQ_ACCOUNTS.nextval;
    if(mainmenu_ <> '-1') then
      insert into ACCOUNTS(ID,USERNAME,PASSWORD,IDGROUP,ACTIVE,IDKHUVUC,IDPHONGBAN,MAINMENU) values (n,username_,password_, idgroup_, active_,idkhuvuc_,idphongban_,mainmenu_);
    else
      insert into ACCOUNTS(ID,USERNAME,PASSWORD,IDGROUP,ACTIVE,IDKHUVUC,IDPHONGBAN,MAINMENU) values (n,username_,password_, idgroup_, active_,idkhuvuc_,idphongban_,null);
    end if;
    return n;
  end if;
  RETURN id_;
END SAVE_ACCOUNT;

/

--------------------------------------------------------
--  DDL for Function SAVE_VMSGROUP
--------------------------------------------------------

  CREATE OR REPLACE FUNCTION "THUEKENH"."SAVE_VMSGROUP" 
(
	id_	in VARCHAR2,
	namegroup_ in VARCHAR2,
  mainmenu_ in VARCHAR2
)
RETURN NUMBER AS
n NUMBER;
BEGIN
	if(id_ is not null) then --update
      update VMSGROUP set NAMEGROUP = namegroup_, MAINMENU = mainmenu_ where ID = to_number(id_);
	else --insert
		n := SEQ_VMSGROUP.nextval;
    if(mainmenu_ <> '-1') then
      insert into VMSGROUP(ID,NAMEGROUP,ACTIVE,MAINMENU) values (n,namegroup_,1,mainmenu_);
    else
      insert into VMSGROUP(ID,NAMEGROUP,ACTIVE,MAINMENU) values (n,namegroup_,1,null);
    end if;
    return n;
  end if;
  RETURN id_;
END SAVE_VMSGROUP;

/

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
        TRANGTHAI= trangthai_,
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

--------------------------------------------------------
--  DDL for Function FN_FIND_SUCO_FOR_TT
--------------------------------------------------------

  CREATE OR REPLACE FUNCTION "THUEKENH"."FN_FIND_SUCO_FOR_TT" 
(
  iDisplayStart IN NUMBER,   
  iDisplayLength IN NUMBER, 
  tungay_ in varchar2,
  denngay_ in varchar2,
  phulucids_ in varchar2
) 
RETURN SYS_REFCURSOR AS l_cursor SYS_REFCURSOR;
v_vcsql VARCHAR2(2000);
v_vcsqlwhere VARCHAR2(1000);
i NUMBER;
BEGIN
	v_vcsqlwhere := ' sc.DELETED = 0 ';
	if(tungay_ is not null) then
		v_vcsqlwhere := v_vcsqlwhere ||' and sc.THOIDIEMBATDAU >= '||tungay_||' ';
	end if;
	if(denngay_ is not null) then
		v_vcsqlwhere := v_vcsqlwhere ||' and sc.THOIDIEMBATDAU <= '||denngay_||' ';
	end if;
  if(phulucids_ is not null) then
		v_vcsqlwhere := v_vcsqlwhere ||' and sc.PHULUC_ID in ('||phulucids_||') ';
	end if;
	v_vcsql := 'select rownum as rn,dulieu.* from (SELECT sc.id ,t.ID tuyenkenh_id,t.MADIEMDAU,t.MADIEMCUOI,sc.LOAISUCO,t.GIAOTIEP_ID,gt.LOAIGIAOTIEP,t.DUNGLUONG,t.SOLUONG,sc.THOIDIEMBATDAU,sc.THOIDIEMKETTHUC,
                                                        sc.THOIGIANMLL,sc.NGUYENNHAN,sc.PHUONGANXULY,sc.NGUOIXACNHAN,sc.FILENAME,sc.FILEPATH,sc.FILESIZE,sc.USERCREATE,sc.TIMECREATE,sc.BIENBANVANHANH_ID
                                                 FROM SUCOKENH sc  
                                                      LEFT JOIN TUYENKENH t ON sc.TUYENKENH_ID = t.ID 
                                                      LEFT JOIN LOAIGIAOTIEP gt ON t.GIAOTIEP_ID=gt.ID
                                                 WHERE ' || v_vcsqlwhere || ' ORDER BY sc.THOIDIEMBATDAU desc) dulieu ';
	v_vcsql := 'SELECT * FROM (' || v_vcsql || ') WHERE rn > ' || iDisplayStart || ' and rn <= ' || (iDisplayStart+iDisplayLength);
	--dbms_output.put_line(v_vcsql);
  --test(v_vcsql);
	OPEN l_cursor FOR v_vcsql;
	RETURN l_cursor;
END FN_FIND_SUCO_FOR_TT;

/

--------------------------------------------------------
--  DDL for Function FIND_TUYENKENHIMPORT
--------------------------------------------------------

  CREATE OR REPLACE FUNCTION "THUEKENH"."FIND_TUYENKENHIMPORT" (
iDisplayStart IN NUMBER,   
iDisplayLength IN NUMBER
) RETURN SYS_REFCURSOR AS
l_cursor SYS_REFCURSOR;
v_vcsql VARCHAR2(2000);
i NUMBER;
BEGIN
	v_vcsql := 'select rownum as rn,dulieu.* from (SELECT t.ID,t.STT, t.MADIEMDAU, t.MADIEMCUOI, t.GIAOTIEP_MA, t.DUAN_MA, t.PHONGBAN_MA, t.DOITAC_MA, t.DUNGLUONG, t.SOLUONG,TENDUAN,LOAIGIAOTIEP,TENPHONGBAN,TENDOITAC,DUPLICATE,t.TRANGTHAI FROM TUYENKENH_IMPORT t left join LOAIGIAOTIEP t0 on t.GIAOTIEP_MA = t0.MA left join DUAN t1 on t.DUAN_MA = t1.MA left join PHONGBAN t2 on t.PHONGBAN_MA = t2.MA left join DOITAC t3 on t.DOITAC_MA=t3.MA order by t.STT) dulieu ';
	v_vcsql := 'SELECT * FROM (' || v_vcsql || ') WHERE rn > ' || iDisplayStart || ' and rn <= ' || (iDisplayStart+iDisplayLength);
	--dbms_output.put_line(v_vcsql);
 --test(v_vcsql);
	OPEN l_cursor FOR v_vcsql;
	RETURN l_cursor;
END FIND_TUYENKENHIMPORT;

/

--------------------------------------------------------
--  DDL for Function FIND_CHITIETPHULUC
--------------------------------------------------------

  CREATE OR REPLACE FUNCTION "THUEKENH"."FIND_CHITIETPHULUC" (
iDisplayStart IN NUMBER,   
iDisplayLength IN NUMBER, 
tenchitietphuluc_ in varchar2
) RETURN SYS_REFCURSOR AS
l_cursor SYS_REFCURSOR;
v_vcsql VARCHAR2(2000);
v_vcsqlwhere VARCHAR2(1000);
i NUMBER;
BEGIN
	v_vcsqlwhere := ' t.DELETED = 0 ';
	if(tenchitietphuluc_ is not null) then
		v_vcsqlwhere := v_vcsqlwhere ||' and t.TENCHITIETPHULUC like ''%'||tenchitietphuluc_||'%'' ';
	end if;
	v_vcsql := 'select rownum as rn,dulieu.* from (SELECT t.* FROM CHITIETPHULUC t WHERE ' || v_vcsqlwhere || ' order by t.ID desc) dulieu ';
	v_vcsql := 'SELECT * FROM (' || v_vcsql || ') WHERE rn > ' || iDisplayStart || ' and rn <= ' || (iDisplayStart+iDisplayLength);
	--dbms_output.put_line(v_vcsql);
 --test(v_vcsql);
	OPEN l_cursor FOR v_vcsql;
	RETURN l_cursor;
END FIND_CHITIETPHULUC;

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
--  DDL for Function FIND_TUYENKENHBANGIAO
--------------------------------------------------------

  CREATE OR REPLACE FUNCTION "THUEKENH"."FIND_TUYENKENHBANGIAO" (
iDisplayStart IN NUMBER,   
iDisplayLength IN NUMBER, 
makenh_ in varchar2,
loaigiaotiep_ in varchar2,
madiemdau_ in varchar2,
madiemcuoi_ in varchar2,
duan_ in varchar2,
ngaydenghibangiao_ in varchar2,
ngayhenbangiao_ in varchar2,
dexuat_id_ in varchar2,
khuvuc_id in varchar2,
phongban_id in varchar2,
isAllow in varchar2,
iTrangThai in nvarchar2
) RETURN SYS_REFCURSOR AS
l_cursor SYS_REFCURSOR;
v_vcsql VARCHAR2(2000);
v_vcsqlwhere VARCHAR2(1000);
i NUMBER;
BEGIN
	v_vcsqlwhere := ' t.DELETED = 0 ';--and t0.khuvuc_id='''||khuvuc_id||'''';
  if(isAllow = '0' ) then
		v_vcsqlwhere := v_vcsqlwhere || 'and t4.khuvuc_id='''||khuvuc_id||''' and t0.PHONGBAN_ID ='''||phongban_id||'''';
	end if;

  if(dexuat_id_ is not null) then
		v_vcsqlwhere := v_vcsqlwhere ||' and t.DEXUAT_ID = '||dexuat_id_||' ';
	end if;
	if(makenh_ is not null) then
		v_vcsqlwhere := v_vcsqlwhere ||' and t0.ID like '''||replace(makenh_, '*', '%')||'%'' ';
	end if;
	if(loaigiaotiep_ is not null) then
		v_vcsqlwhere := v_vcsqlwhere ||' and GIAOTIEP_ID = '||loaigiaotiep_||' ';
	end if;
	if(duan_ is not null) then
		v_vcsqlwhere := v_vcsqlwhere ||' and t0.DUAN_ID = '||duan_||' ';
	end if;
	if(madiemdau_ is not null) then
		v_vcsqlwhere := v_vcsqlwhere ||' and t0.MADIEMDAU like '''||replace(madiemdau_, '*', '%')||''' ';
	end if;
	if(madiemcuoi_ is not null) then
		v_vcsqlwhere := v_vcsqlwhere ||' and t0.MADIEMCUOI like '''||replace(madiemcuoi_, '*', '%')||''' ';
	end if;
	if(ngaydenghibangiao_ is not null) then
		v_vcsqlwhere := v_vcsqlwhere ||' and t.NGAYDENGHIBANGIAO = TO_DATE('''||ngaydenghibangiao_||''',''DD-MM-RRRR'') ';
	end if;
	if(ngayhenbangiao_ is not null) then
		v_vcsqlwhere := v_vcsqlwhere ||' and t.NGAYHENBANGIAO = TO_DATE('''||ngayhenbangiao_||''',''DD-MM-RRRR'') ';
	end if;
	v_vcsql := 'select rownum as rn,dulieu.* from (
              SELECT t.ID as ID,t0.ID as TUYENKENH_ID,MADIEMDAU,MADIEMCUOI,t1.LOAIGIAOTIEP,t0.giaotiep_id,t0.DUAN_ID,t0.DUNGLUONG,t.SOLUONG,dx.tenvanban as tenvanbandexuat,t2.tenduan,tiendo,dx.id as MAVANBANDEXUAT,TENPHONGBAN,tendoitac
FROM TUYENKENHDEXUAT t 
left join TUYENKENH t0 on t.TUYENKENH_ID = t0.ID 
left join LOAIGIAOTIEP t1 on t0.GIAOTIEP_ID = t1.ID 
left join DUAN t2 on t0.DUAN_ID = t2.ID 
left join PHONGBAN t3 on t0.PHONGBAN_ID = t3.ID
left join Doitac t4 on t0.DoiTac_id = t4.ID
left join dexuat dx on dx.id=t.dexuat_id
where  t.trangthai='||iTrangThai||' and '|| v_vcsqlwhere || ' order by t0.ID desc) dulieu ';
	v_vcsql := 'SELECT * FROM (' || v_vcsql || ') WHERE rn >= ' || iDisplayStart || ' and rn <= ' || (iDisplayStart+iDisplayLength);
	--dbms_output.put_line(v_vcsql);
 test(v_vcsql);
	OPEN l_cursor FOR v_vcsql;
	RETURN l_cursor;
END FIND_TUYENKENHBANGIAO;

/

--------------------------------------------------------
--  DDL for Function FN_FIND_SUCO_BY_DSCUOC
--------------------------------------------------------

  CREATE OR REPLACE FUNCTION "THUEKENH"."FN_FIND_SUCO_BY_DSCUOC" 
(
  iDisplayStart IN NUMBER,   
  iDisplayLength IN NUMBER, 
  doisoatcuoc_id_ in varchar2
) 
RETURN SYS_REFCURSOR AS l_cursor SYS_REFCURSOR;
v_vcsql VARCHAR2(2000);
v_vcsqlwhere VARCHAR2(1000);
i NUMBER;
BEGIN
	v_vcsqlwhere := ' sc.DELETED = 0 ';
  if(doisoatcuoc_id_ is not null) then
		v_vcsqlwhere := v_vcsqlwhere ||' and ds.DOISOATCUOC_ID='||doisoatcuoc_id_||' ';
	end if;
	v_vcsql := 'select rownum as rn,dulieu.* from (SELECT sc.id ,t.ID tuyenkenh_id,t.MADIEMDAU,t.MADIEMCUOI,sc.LOAISUCO,t.GIAOTIEP_ID,gt.LOAIGIAOTIEP,t.DUNGLUONG,t.SOLUONG,sc.THOIDIEMBATDAU,sc.THOIDIEMKETTHUC,
                                                        sc.THOIGIANMLL,sc.NGUYENNHAN,sc.PHUONGANXULY,sc.NGUOIXACNHAN,sc.FILENAME,sc.FILEPATH,sc.FILESIZE,sc.USERCREATE,sc.TIMECREATE,sc.BIENBANVANHANH_ID
                                                 FROM SUCOKENH sc  
                                                      LEFT JOIN TUYENKENH t ON sc.TUYENKENH_ID = t.ID 
                                                      LEFT JOIN LOAIGIAOTIEP gt ON t.GIAOTIEP_ID=gt.ID
                                                      LEFT JOIN DOISOATCUOC_SUCO ds ON ds.SUCO_ID=sc.ID
                                                 WHERE ' || v_vcsqlwhere || ' ORDER BY sc.THOIDIEMBATDAU desc) dulieu ';
	v_vcsql := 'SELECT * FROM (' || v_vcsql || ') WHERE rn > ' || iDisplayStart || ' and rn <= ' || (iDisplayStart+iDisplayLength);
	--dbms_output.put_line(v_vcsql);
  --test(v_vcsql);
	OPEN l_cursor FOR v_vcsql;
	RETURN l_cursor;
END FN_FIND_SUCO_BY_DSCUOC;

/

--------------------------------------------------------
--  DDL for Function FN_GETMENUIDBYUSER
--------------------------------------------------------

  CREATE OR REPLACE FUNCTION "THUEKENH"."FN_GETMENUIDBYUSER" (
idaccount_ in varchar2,
idgroup_ in varchar2
) RETURN SYS_REFCURSOR AS
l_cursor SYS_REFCURSOR;
----========================================================================
-- @project: VMS quan ly kenh truyen dan
-- @description: Lay danh sach menu ID cua user, tra ve dang List ID
-- @author	nclong
-- @date Nov 21, 2012
-- @param
-- @vesion 1.0
-- @copyright nclong
---- @date update 
---- @user update
---- @note: 
----========================================================================
BEGIN
	open l_cursor for select m.ID from menu m,user_menu u where m.active = 1 and m.id=u.menuid and accountid=idaccount_ union select t3.ID from group_menu t1,vmsgroup t2,menu t3 where t3.active = 1 and t1.idmenu=t3.id and t1.idgroup=t2.id  and t2.active=1 and t2.id= idgroup_;
	RETURN l_cursor;
END FN_GETMENUIDBYUSER;

/

--------------------------------------------------------
--  DDL for Function CAPNHATTIENDO
--------------------------------------------------------

  CREATE OR REPLACE FUNCTION "THUEKENH"."CAPNHATTIENDO" 
(
tuyenkenh_tieuchuan_id_ in varchar2,
tieuchuan_id_ in varchar2,
username_ in varchar2
)
return number as 
iCount number:=0;
begin
  select count(*) into iCount from TUYENKENH_TIEUCHUAN where TUYENKENHDEXUAT_ID=tuyenkenh_tieuchuan_id_ and TIEUCHUAN_ID=tieuchuan_id_;
  if ( iCount = 0) then

    INSERT INTO TUYENKENH_TIEUCHUAN (TUYENKENHDEXUAT_ID, TIEUCHUAN_ID, USERCREATE, TIMECREATE, DELETED) 
    VALUES (tuyenkenh_tieuchuan_id_, tieuchuan_id_, username_, sysdate, '0');

    else

    update TUYENKENH_TIEUCHUAN set deleted=0 
    where TUYENKENHDEXUAT_ID=tuyenkenh_tieuchuan_id_ and TIEUCHUAN_ID=tieuchuan_id_ and deleted=1;
    
end if;
  return null;
end capnhattiendo;

/

--------------------------------------------------------
--  DDL for Function FIND_BANGIAO
--------------------------------------------------------

  CREATE OR REPLACE FUNCTION "THUEKENH"."FIND_BANGIAO" (
iDisplayStart IN NUMBER,   
iDisplayLength IN NUMBER, 
sobienban_ in varchar2
) RETURN SYS_REFCURSOR AS
l_cursor SYS_REFCURSOR;
v_vcsql VARCHAR2(2000);
i NUMBER;
BEGIN
if(sobienban_ is null) then
	v_vcsql := 'select rownum as rn,dulieu.* from (select * from bangiao where deleted=0) dulieu ';
  else
  	v_vcsql := 'select rownum as rn,dulieu.* from (select * from bangiao where deleted=0 and sobienban like ''%'|| sobienban_ ||'%'') dulieu ';
end if;
	v_vcsql := 'SELECT * FROM (' || v_vcsql || ') WHERE rn > ' || iDisplayStart || ' and rn <= ' || (iDisplayStart+iDisplayLength);
	--dbms_output.put_line(v_vcsql);
 --test(v_vcsql);
	OPEN l_cursor FOR v_vcsql;
	RETURN l_cursor;
END FIND_BANGIAO;

/

--------------------------------------------------------
--  DDL for Function FN_FIND_LICHSUPHULUC
--------------------------------------------------------

  CREATE OR REPLACE FUNCTION "THUEKENH"."FN_FIND_LICHSUPHULUC" (
iDisplayStart IN NUMBER,   
iDisplayLength IN NUMBER, 
phuluc_id_ in varchar2
) RETURN SYS_REFCURSOR AS
l_cursor SYS_REFCURSOR;
v_vcsql VARCHAR2(2000);
i NUMBER;
BEGIN
	v_vcsql := 'select rownum as rn,dulieu.* from (SELECT * FROM LICHSU_PHULUC t where t.PHULUC_ID='''||phuluc_id_||''' order by t.TIMEACTION desc) dulieu ';
	v_vcsql := 'SELECT * FROM (' || v_vcsql || ') WHERE rn > ' || iDisplayStart || ' and rn <= ' || (iDisplayStart+iDisplayLength);
	OPEN l_cursor FOR v_vcsql;
	RETURN l_cursor;
END FN_FIND_LICHSUPHULUC;

/

--------------------------------------------------------
--  DDL for Function FN_FIND_HOPDONGBY_DSCUOC
--------------------------------------------------------

  CREATE OR REPLACE FUNCTION "THUEKENH"."FN_FIND_HOPDONGBY_DSCUOC" 
(
  doisoatcuoc_id_ in varchar2
) 
RETURN SYS_REFCURSOR AS l_cursor SYS_REFCURSOR;
v_vcsql VARCHAR2(2000);
i NUMBER;
BEGIN
	v_vcsql := 'select rownum as rn,dulieu.* from (SELECT DISTINCT hd.*,dt.TENDOITAC
                                                 FROM DOISOATCUOC_PHULUC dp INNER JOIN PHULUC p ON dp.PHULUC_ID=p.ID 
                                                 INNER JOIN HOPDONG hd ON hd.ID=p.HOPDONG_ID 
                                                 INNER JOIN DOITAC dt ON hd.DOITAC_ID=dt.ID
                                                 WHERE dp.DOISOATCUOC_ID=' || doisoatcuoc_id_ || ') dulieu ';
	OPEN l_cursor FOR v_vcsql;
	RETURN l_cursor;
END FN_FIND_HOPDONGBY_DSCUOC;

/

--------------------------------------------------------
--  DDL for Function FIND_PHULUC
--------------------------------------------------------

  CREATE OR REPLACE FUNCTION "THUEKENH"."FIND_PHULUC" (
iDisplayStart IN NUMBER,   
iDisplayLength IN NUMBER, 
tenhopdong_ in varchar2,
tenphuluc_ in varchar2,
loaiphuluc_ in varchar2,
trangthai_ in varchar2,
ngayky_from in varchar2,
ngayky_end in varchar2,
ngayhieuluc_from in varchar2,
ngayhieuluc_end in varchar2,
hopdong_id_ in varchar2
) RETURN SYS_REFCURSOR AS
l_cursor SYS_REFCURSOR;
v_vcsql VARCHAR2(2000);
v_vcsqlwhere VARCHAR2(1000);
i NUMBER;
BEGIN
	v_vcsqlwhere := ' t.DELETED = 0 ';
	if(tenhopdong_ is not null) then
		v_vcsqlwhere := v_vcsqlwhere ||' and t0.ID = '''||tenhopdong_||''' ';
	end if;
	if(tenphuluc_ is not null) then
		v_vcsqlwhere := v_vcsqlwhere ||' and t.TENPHULUC like ''%'||tenphuluc_||'%'' ';
	end if;
	if(loaiphuluc_ is not null) then
		v_vcsqlwhere := v_vcsqlwhere ||' and t.LOAIPHULUC = '||loaiphuluc_||' ';
	end if;
	if(trangthai_ is not null) then
		v_vcsqlwhere := v_vcsqlwhere ||' and t.TRANGTHAI = '||trangthai_||' ';
	end if;
	if(ngayky_from is not null) then
		v_vcsqlwhere := v_vcsqlwhere ||' and t.NGAYKY >= TO_DATE('''||ngayky_from||''',''DD-MM-RRRR'') ';
	end if;
	if(ngayky_end is not null) then
		v_vcsqlwhere := v_vcsqlwhere ||' and t.NGAYKY <= TO_DATE('''||ngayky_end||''',''DD-MM-RRRR'') ';
	end if;
	if(ngayhieuluc_from is not null) then
		v_vcsqlwhere := v_vcsqlwhere ||' and t.NGAYHIEULUC >= TO_DATE('''||ngayhieuluc_from||''',''DD-MM-RRRR'') ';
	end if;
	if(ngayhieuluc_end is not null) then
		v_vcsqlwhere := v_vcsqlwhere ||' and t.NGAYHIEULUC <= TO_DATE('''||ngayhieuluc_end||''',''DD-MM-RRRR'') ';
	end if;
	if(hopdong_id_ is not null) then
		v_vcsqlwhere := v_vcsqlwhere ||' and t.HOPDONG_ID = '||hopdong_id_||' ';
	end if;
	v_vcsql := 'select rownum as rn,dulieu.* from (SELECT t.*,t0.SOHOPDONG,t0.LOAIHOPDONG,t0.DOITAC_ID,t2.TENDOITAC,FIND_PHULUC_BITHAYTHE(t.ID) as PHULUCBITHAYTHE FROM PHULUC t 
		left join HOPDONG t0 on t.HOPDONG_ID = t0.ID 
		left join DOITAC t2 on t0.DOITAC_ID = t2.ID  WHERE ' || v_vcsqlwhere || ' order by t.ID desc) dulieu ';
	v_vcsql := 'SELECT * FROM (' || v_vcsql || ') WHERE rn > ' || iDisplayStart || ' and rn <= ' || (iDisplayStart+iDisplayLength);
	--dbms_output.put_line(v_vcsql);
 --test(v_vcsql);
	OPEN l_cursor FOR v_vcsql;
	RETURN l_cursor;
END FIND_PHULUC;

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
timecreate_ in number,
matlienlactu_ in date,
matlienlacden_ in date
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
	insert into DOISOATCUOC(ID,DOITAC_ID,TUNGAY,DENNGAY,TIMECREATE,DELETED,MATLIENLACTU,MATLIENLACDEN) values (vDoiSoatCuocId,doitac_id_,tungay_,denngay_,timecreate_,timecreate_,matlienlactu_,matlienlacden_);
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
		vDaThanhToan := 0;
		if(vSoNgay < 0) then -- lay lai so tien da thanh toan cho phu luc nay o thang truoc (do ky tre)
			for recDSC_PL in (select t2.* from thanhtoan t left join doisoatcuoc t1 on t.doisoatcuoc_id = t1.id left join doisoatcuoc_phuluc t2 on t2.doisoatcuoc_id = t1.id where t2.phuluc_id = rec.ID and t1.tungay <= vDenNgay and t1.denngay >= vDenNgay order by t.TIMECREATE desc) loop
				vSoNgay := vSoNgay + (recDSC_PL.SOTHANG * 30) + recDSC_PL.SONGAY;
				vDaThanhToan := vDaThanhToan + recDSC_PL.CONTHANHTOAN;
				vTuNgay := recDSC_PL.TUNGAY;
			end loop;
		end if;
		vThanhTien := floor(rec.GIATRITRUOCTHUE / 30 * vSoNgay);
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
--  DDL for Function FN_FIND_SUCO
--------------------------------------------------------

  CREATE OR REPLACE FUNCTION "THUEKENH"."FN_FIND_SUCO" 
(
  iDisplayStart IN NUMBER,   
  iDisplayLength IN NUMBER, 
  tuyenkenh_id_ in varchar2,
  loaisuco_ in varchar2,
  diemdau_ in varchar2,
  diemcuoi_ in varchar2,
  dungluong_ in varchar2,
  thoidiembatdautu_ in varchar2,
  thoidiembatdauden_ in varchar2,
  thoidiemketthuctu_ in varchar2,
  thoidiemketthucden_ in varchar2,
  nguoixacnhan_ in varchar2,
  bienbanvanhanh_id_ in varchar2
) 
RETURN SYS_REFCURSOR AS l_cursor SYS_REFCURSOR;
v_vcsql VARCHAR2(2000);
v_vcsqlwhere VARCHAR2(1000);
i NUMBER;
BEGIN
	v_vcsqlwhere := ' sc.DELETED = 0 ';
	if(tuyenkenh_id_ is not null) then
		v_vcsqlwhere := v_vcsqlwhere ||' AND sc.TUYENKENH_ID = '''||tuyenkenh_id_||''' ';
	end if;
  if(loaisuco_ is not null) then
		v_vcsqlwhere := v_vcsqlwhere ||' AND sc.LOAISUCO = '||loaisuco_||' ';
	end if;
	if(diemdau_ is not null) then
		v_vcsqlwhere := v_vcsqlwhere ||' AND t.MADIEMDAU like '''||replace(diemdau_, '*', '%')||''' ';
	end if;
	if(diemcuoi_ is not null) then
		v_vcsqlwhere := v_vcsqlwhere ||' AND t.MADIEMCUOI like '''||replace(diemcuoi_, '*', '%')||''' ';
	end if;
	if(dungluong_ is not null) then
		v_vcsqlwhere := v_vcsqlwhere ||' and t.DUNGLUONG = '||dungluong_ ||' ';
	end if;
	if(thoidiembatdautu_ is not null) then
		v_vcsqlwhere := v_vcsqlwhere ||' and sc.THOIDIEMBATDAU >= '||thoidiembatdautu_||' ';
	end if;
	if(thoidiembatdauden_ is not null) then
		v_vcsqlwhere := v_vcsqlwhere ||' and sc.THOIDIEMBATDAU <= '||thoidiembatdauden_||' ';
	end if;
  if(thoidiemketthuctu_ is not null) then
		v_vcsqlwhere := v_vcsqlwhere ||' and sc.THOIDIEMKETTHUC >= '||thoidiemketthuctu_||' ';
	end if;
	if(thoidiemketthucden_ is not null) then
		v_vcsqlwhere := v_vcsqlwhere ||' and sc.THOIDIEMKETTHUC <= '||thoidiemketthucden_||' ';
	end if;
	if(nguoixacnhan_ is not null) then
		v_vcsqlwhere := v_vcsqlwhere ||' and sc.NGUOIXACNHAN like '''||replace(nguoixacnhan_, '*', '%')||''' ';
	end if;
  if(bienbanvanhanh_id_ is not null) then
		v_vcsqlwhere := v_vcsqlwhere ||' and sc.BIENBANVANHANH_ID='||bienbanvanhanh_id_||' ';
	end if;
	v_vcsql := 'select rownum as rn,dulieu.* from (SELECT sc.id ,t.ID tuyenkenh_id,t.MADIEMDAU,t.MADIEMCUOI,sc.LOAISUCO,t.GIAOTIEP_ID,gt.LOAIGIAOTIEP,t.DUNGLUONG,t.SOLUONG,sc.THOIDIEMBATDAU,sc.THOIDIEMKETTHUC,
                                                        sc.THOIGIANMLL,sc.NGUYENNHAN,sc.PHUONGANXULY,sc.NGUOIXACNHAN,sc.FILENAME,sc.FILEPATH,sc.FILESIZE,sc.USERCREATE,sc.TIMECREATE,sc.BIENBANVANHANH_ID
                                                 FROM SUCOKENH sc  
                                                      LEFT JOIN TUYENKENH t ON sc.TUYENKENH_ID = t.ID 
                                                      LEFT JOIN LOAIGIAOTIEP gt ON t.GIAOTIEP_ID=gt.ID
                                                 WHERE ' || v_vcsqlwhere || ' ORDER BY sc.THOIDIEMBATDAU desc) dulieu ';
	v_vcsql := 'SELECT * FROM (' || v_vcsql || ') WHERE rn > ' || iDisplayStart || ' and rn <= ' || (iDisplayStart+iDisplayLength);
	--dbms_output.put_line(v_vcsql);
  --test(v_vcsql);
	OPEN l_cursor FOR v_vcsql;
	RETURN l_cursor;
END FN_FIND_SUCO;

/

--------------------------------------------------------
--  DDL for Function SAVE_TUYENKENHDEXUAT
--------------------------------------------------------

  CREATE OR REPLACE FUNCTION "THUEKENH"."SAVE_TUYENKENHDEXUAT" (
id_ in VARCHAR2,
tuyenkenh_id_ in VARCHAR2,
madiemdau_ in VARCHAR2,
madiemcuoi_ in VARCHAR2,
giaotiep_id_ in VARCHAR2,
duan_id_ in VARCHAR2,
phongban_id_ in VARCHAR2,
doitac_id_ in VARCHAR2,
dungluong_ in VARCHAR2,
ngaydenghibangiao_ in VARCHAR2,
ngayhenbangiao_ in VARCHAR2,
thongtinlienhe_ in VARCHAR2,
soluong_ in NUMBER,
soluong_old in NUMBER,
usercreate_ in VARCHAR2,
timecreate_ in VARCHAR2
) RETURN NUMBER AS
i INTEGER := 0;
madoitac varchar2(50);
matuyenkenh varchar2(20);
id_tuyenkenh varchar2(50);
str varchar2(500) := '';
BEGIN
	if(tuyenkenh_id_ is not null) then --update
		update TUYENKENH set GIAOTIEP_ID = giaotiep_id_,DUAN_ID = duan_id_,PHONGBAN_ID = phongban_id_,DOITAC_ID = doitac_id_,DUNGLUONG = dungluong_,SOLUONG = SOLUONG + (soluong_ - soluong_old),TRANGTHAI_BAK = TRANGTHAI, TRANGTHAI = 2  where ID = tuyenkenh_id_ and DELETED = 0;
		id_tuyenkenh := tuyenkenh_id_;
    PROC_INSERT_LICHSU_TUYENKENH(usercreate_,id_tuyenkenh,3,'');
	else --insert
		i:=GET_SOTUYENKENH(doitac_id_) + 1;
		select ma into madoitac from doitac where id = doitac_id_;
		id_tuyenkenh := madoitac||'_'||TRIM(to_char(i,'0009'));
		insert into TUYENKENH(ID, MADIEMDAU, MADIEMCUOI, GIAOTIEP_ID, DUAN_ID, PHONGBAN_ID, DOITAC_ID, DUNGLUONG, SOLUONG, TRANGTHAI, USERCREATE, TIMECREATE, DELETED) values (id_tuyenkenh, madiemdau_, madiemcuoi_, giaotiep_id_, duan_id_, phongban_id_, doitac_id_, dungluong_, soluong_, 1, usercreate_, timecreate_, 0);
		PROC_INSERT_LICHSU_TUYENKENH(usercreate_,id_tuyenkenh,1,'');
	end if;
	if(id_ is not null and id_>0) then --update
		update TUYENKENHDEXUAT set TUYENKENH_ID = id_tuyenkenh,NGAYDENGHIBANGIAO = ngaydenghibangiao_,NGAYHENBANGIAO = ngayhenbangiao_,THONGTINLIENHE = thongtinlienhe_,SOLUONG = soluong_ where ID = id_;
		i := id_;
		str := '<root><element><id>'||i||'</id></element></root>';
		PROC_INSERT_LICHSU_TUYENKENH(usercreate_,id_tuyenkenh,8,str);
	else --insert
		i:=SEQ_TUYENKENHDEXUAT.nextval;
		insert into TUYENKENHDEXUAT(ID, DEXUAT_ID, TUYENKENH_ID, BANGIAO_ID, NGAYDENGHIBANGIAO, NGAYHENBANGIAO, THONGTINLIENHE, TRANGTHAI, SOLUONG) values (i, NULL, id_tuyenkenh, NULL, ngaydenghibangiao_, ngayhenbangiao_, thongtinlienhe_, 0, soluong_);
		str := '<root><element><id>'||i||'</id></element></root>';
		PROC_INSERT_LICHSU_TUYENKENH(usercreate_,id_tuyenkenh,6,str);
	end if;
	return i;
END SAVE_TUYENKENHDEXUAT;

/

--------------------------------------------------------
--  DDL for Function FN_FIND_PHULUCBY_THANHTOAN
--------------------------------------------------------

  CREATE OR REPLACE FUNCTION "THUEKENH"."FN_FIND_PHULUCBY_THANHTOAN" 
(
  thanhtoan_id_ in varchar2,
  hopdong_id_ in varchar2
) 
RETURN SYS_REFCURSOR AS l_cursor SYS_REFCURSOR;
v_vcsql VARCHAR2(2000);
i NUMBER;
BEGIN
	v_vcsql := 'select rownum as rn,dulieu.* from (SELECT tp.PHULUC_ID
                                                 FROM THANHTOAN_PHULUC tp INNER JOIN PHULUC p ON tp.PHULUC_ID=p.ID   
                                                 WHERE tp.THANHTOAN_ID=' || thanhtoan_id_ || ' AND p.HOPDONG_ID=' || hopdong_id_ || ') dulieu ';
	OPEN l_cursor FOR v_vcsql;
	RETURN l_cursor;
END FN_FIND_PHULUCBY_THANHTOAN;

/

--------------------------------------------------------
--  DDL for Function FIND_SUCOIMPORT
--------------------------------------------------------

  CREATE OR REPLACE FUNCTION "THUEKENH"."FIND_SUCOIMPORT" (
iDisplayStart IN NUMBER,   
iDisplayLength IN NUMBER
) RETURN SYS_REFCURSOR AS
l_cursor SYS_REFCURSOR;
v_vcsql VARCHAR2(2000);
i NUMBER;
BEGIN
	v_vcsql := 'select rownum as rn,dulieu.* from (SELECT t.ID,t.STT, t.MADIEMDAU, t.MADIEMCUOI,t.DUNGLUONG, t.MAGIAOTIEP, t.THOIDIEMBATDAU, t.THOIDIEMKETTHUC, t.NGUYENNHAN, t.PHUONGANXULY, t.TUYENKENH_ID,t.NGUOIXACNHAN,t.LOAISUCO,t0.LOAIGIAOTIEP,t.PHULUC_ID,pl.TENPHULUC 
                                                 FROM SUCO_IMPORT t left join LOAIGIAOTIEP t0 on t.MAGIAOTIEP = t0.MA
                                                 left join PHULUC pl on pl.id=t.PHULUC_ID
                                                 order by t.STT) dulieu ';
	v_vcsql := 'SELECT * FROM (' || v_vcsql || ') WHERE rn > ' || iDisplayStart || ' and rn <= ' || (iDisplayStart+iDisplayLength);
	--dbms_output.put_line(v_vcsql);
 --test(v_vcsql);
	OPEN l_cursor FOR v_vcsql;
	RETURN l_cursor;
END FIND_SUCOIMPORT;

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
		v_vcsqlwhere := v_vcsqlwhere ||' and t0.FLAG = '||flag_||' ';
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
--  DDL for Function GET_MENU_BY_ACCOUNT
--------------------------------------------------------

  CREATE OR REPLACE FUNCTION "THUEKENH"."GET_MENU_BY_ACCOUNT" (
account_id in varchar2
) RETURN SYS_REFCURSOR AS
l_cursor SYS_REFCURSOR;
i NUMBER;
BEGIN
	OPEN l_cursor FOR select t1.* from USER_MENU t0 left join MENU t1 on t0.MENUID = t1.ID where ACCOUNTID = account_id;
	RETURN l_cursor;
END GET_MENU_BY_ACCOUNT;

/

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
  bienbanvanhanh_id_ in varchar2
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
        BIENBANVANHANH_ID=bienbanvanhanh_id_
    WHERE ID= id_;
    i:= id_;
  ELSE -- insert
    i:=SEQ_SUCO.nextval;
    INSERT INTO SUCOKENH(ID,TUYENKENH_ID,LOAISUCO,PHULUC_ID,THANHTOAN_ID,THOIDIEMBATDAU,THOIDIEMKETTHUC,THOIGIANMLL,NGUYENNHAN,PHUONGANXULY,NGUOIXACNHAN,GIAMTRUMLL,TRANGTHAI,USERCREATE,TIMECREATE,DELETED,FILENAME,FILEPATH,FILESIZE,BIENBANVANHANH_ID) 
    VALUES (i, tuyenkenh_id_,loaisuco_, phuluc_id_, thanhtoan_id_, thoidiembatdau_, thoidiemketthuc_, thoigianmll_, nguyennhan_, phuonganxuly_, nguoixacnhan_, giamtrumll_, trangthai_, usercreate_, timecreate_, 0,filename_, filepath_, filesize_,bienbanvanhanh_id_);
  END IF;
  RETURN i;
END SAVE_SUCOKENH;

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

