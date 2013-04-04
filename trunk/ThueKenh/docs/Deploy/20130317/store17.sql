ALTER TABLE ACCOUNTS 
ADD (LOGIN_TIME DATE );

--------------------------------------------------------
--  DDL for Procedure PROC_SCHEDULE
--------------------------------------------------------
set define off;

  CREATE OR REPLACE PROCEDURE "THUEKENH"."PROC_SCHEDULE" AS
v_sms_content varchar2(500);
BEGIN
  -- Kiem tra xem de xuat nao da den han ban giao nhung chua ban giao xong
  for rec in (select t.ID,t.TUYENKENH_ID from TUYENKENHDEXUAT t left join TUYENKENH t1 on t.TUYENKENH_ID=t1.ID
where t.DELETED = 0 and t.NGAYHENBANGIAO < sysdate and t.TRANGTHAI = 0 and t.FLAG_SENDMAIL is null) loop
    SEND_SMS(rec.TUYENKENH_ID,2,null);
    SEND_EMAIL(rec.TUYENKENH_ID,2,null);
    update TUYENKENHDEXUAT set FLAG_SENDMAIL = 1 where ID = rec.ID;
  end loop;
  
  -- Send sms nhac nho user dai chua login vao he thong trong vong 2 ngay
  for rec in (select t0.* from accounts t0 left join phongban t1 on t0.idphongban = t1.id where t0.ACTIVE = 1 AND (login_time is null or login_time <= sysdate - 2) and t1.ma != 'KTKT' and t0.phone is not null) loop
    v_sms_content := '[Quan ly kenh thue] SMS nhac nho user '||rec.username|| ' nhap su co';
    insert into sms values (sysdate,rec.phone,v_sms_content,4);
    INSERT INTO SMS_QUEUE@SMS6(ID, CALLLED_NUMBER,SMS_CONTENT,REQUEST_DATE_TIME,SMS_TYPE,STATUS,SCHEDULE_DATE_TIME,USER_NAME,PC,SMSC_CODE)
    VALUES(SMS_QUEUE_SEQ.NEXTVAL@SMS6, rec.phone, v_sms_content, sysdate, 0, 0, sysdate, 'SYSTEM', '10.18.18.52','NOIMANG');
  end loop;

  -- Cap nhat trang thai ho so thanh toan
END PROC_SCHEDULE;

/


INSERT INTO "THUEKENH"."MENU" (ID, NAMEMENU, ACTION, ACTIVE, IDROOTMENU) VALUES ('27', 'Báo cáo ISO', '/baocao/iso.action', '1', '6');


--------------------------------------------------------
--  DDL for Function FIND_SUCOBYTUYENKENH
--------------------------------------------------------

  CREATE OR REPLACE FUNCTION "THUEKENH"."FIND_SUCOBYTUYENKENH" (
pTuyenKenhId in varchar2,
pFrom in date,
pEnd in date,
pNgayHieuLuc date,
pNgayHetHieuLuc date
) RETURN VARCHAR2 AS
-- Tra ve chuoi dang "<so lan mat su co>;<tong thoi gian mat lien lac>"
l_cursor SYS_REFCURSOR;
vSoLanMll number := 0;
vTongTGMll number:= 0;
vDate1 date;
vDate2 date;
vFrom number;
vEnd number;
BEGIN
  if(pNgayHieuLuc > pFrom) then
    vDate1 := pNgayHieuLuc;
  else 
    vDate1 := pFrom;
  end if;
  if(pNgayHetHieuLuc is null) then
    vDate2 := pEnd;
  else
    if(pNgayHetHieuLuc < pEnd) then
      vDate2 := pNgayHetHieuLuc;
    else 
      vDate2 := pEnd;
    end if;
  end if;
  vFrom := TO_MILLISECOND(vDate1);
  vEnd := TO_MILLISECOND(vDate2);
  
	for rec in (select * from sucokenh where deleted = 0 and thoidiembatdau >= vFrom and THOIDIEMKETTHUC <= vEnd and TUYENKENH_ID = pTuyenKenhId) loop
		vSoLanMll := vSoLanMll + 1;
		vTongTGMll := vTongTGMll + rec.THOIGIANMLL;
	end loop;
	RETURN '<root><element><solanmll>'||vSoLanMll||'</solanmll><thoigianmll>'||vTongTGMll||'</thoigianmll></element></root>';
END FIND_SUCOBYTUYENKENH;

/

--------------------------------------------------------
--  DDL for Function BC_ISO_TRUYENDANKENHTHUE
--------------------------------------------------------

  CREATE OR REPLACE FUNCTION "THUEKENH"."BC_ISO_TRUYENDANKENHTHUE" (
pFrom in date,
pEnd in date
) RETURN SYS_REFCURSOR AS
l_cursor SYS_REFCURSOR;
BEGIN
  OPEN l_cursor FOR select * from (select rownum as rn,t0.id,diemdau.diachi DIEMDAU,diemcuoi.diachi DIEMCUOI,t0.soluong,t0.dungluong,t2.loaigiaotiep,t0.loaikenh,t3.tendoitac,t6.sohopdong,t5.tenphuluc,t0.ngaybatdau,t4.thanhtien,FIND_SUCOBYTUYENKENH(t0.id,pFrom,pEnd,t5.NGAYHIEULUC,t5.NGAYHETHIEULUC) as SUCOKENH from tuyenkenh t0 
left join tram diemdau on t0.madiemdau = diemdau.matram
left join tram diemcuoi on t0.madiemcuoi = diemcuoi.matram
left join loaigiaotiep t2 on t0.giaotiep_id=t2.id
left join doitac t3 on t3.id = t0.doitac_id
left join chitietphuluc_tuyenkenh t4 on t4.tuyenkenh_id = t0.id
left join phuluc t5 on t5.chitietphuluc_id = t4.CHITIETPHULUC_ID
left join hopdong t6 on t6.id = t5.hopdong_id
where t0.deleted =0 and t5.deleted = 0 and ( (t5.ngayhethieuluc is null and t5.ngayhieuluc  < pEnd + 1) or (t5.ngayhethieuluc is not null and t5.ngayhethieuluc >= pFrom and t5.ngayhieuluc < pEnd + 1 ) )
order by t0.id
) dulieu;
  RETURN l_cursor;
END BC_ISO_TRUYENDANKENHTHUE;

/

CREATE TABLE TUYENKENHDEXUAT_IMPORT 
(
  ID NUMBER NOT NULL 
, MADIEMDAU VARCHAR2(20) 
, MADIEMCUOI VARCHAR2(20) 
, GIAOTIEP_MA VARCHAR2(20) 
, DUAN_MA VARCHAR2(20) 
, DONVINHANKENH_MA VARCHAR2(20) 
, DOITAC_MA VARCHAR2(20) 
, DUNGLUONG VARCHAR2(20) 
, SOLUONGDEXUAT VARCHAR2(20) 
, NGAYHENBANGIAO VARCHAR2(20) 
, NGAYDENGHIBANGIAO VARCHAR2(20) 
, THONGTINLIENHE VARCHAR2(1000) 
, CONSTRAINT TUYENKENHDEXUAT_IMPORT_PK PRIMARY KEY 
  (
    ID 
  )
  ENABLE 
);
ALTER TABLE TUYENKENHDEXUAT_IMPORT 
ADD (STT NUMBER DEFAULT 0 );

ALTER TABLE TUYENKENHDEXUAT_IMPORT 
ADD (DUPLICATE NUMBER );

ALTER TABLE TUYENKENHDEXUAT_IMPORT 
ADD (TUYENKENH_ID VARCHAR2(20) );
ALTER TABLE TUYENKENHDEXUAT_IMPORT 
ADD (SOLUONG_OLD NUMBER DEFAULT 0 );


CREATE SEQUENCE SEQ_TUYENKENHDEXUAT_IMPORT INCREMENT BY 1 START WITH 1 MAXVALUE 9999999999 MINVALUE 1;


--------------------------------------------------------
--  DDL for Procedure PROC_IMPORT_TUYENKENHDEXUAT
--------------------------------------------------------
set define off;

  CREATE OR REPLACE PROCEDURE "THUEKENH"."PROC_IMPORT_TUYENKENHDEXUAT" (
pi_array in TABLE_NUMBER,
usercreate_ in varchar2,
timecreate_ in date
) AS 
i INTEGER := 1;
str varchar2(1000);
BEGIN
	for rec in (SELECT t.*,t0.ID as LOAIGIAOTIEP_ID,t1.ID as PHONGBAN_ID,t2.ID as DOITAC_ID,t3.ID as DUAN_ID  FROM TUYENKENHDEXUAT_IMPORT t left join LOAIGIAOTIEP t0 on t.GIAOTIEP_MA = t0.MA left join PHONGBAN t1 on t.DONVINHANKENH_MA = t1.MA left join DOITAC t2 on t.DOITAC_MA = t2.MA left join DUAN t3 on t.DUAN_MA = t3.MA  where t.ID in (select * from table(pi_array))) loop
		update TUYENKENH set DUAN_ID = rec.DUAN_ID,PHONGBAN_ID = rec.PHONGBAN_ID,DOITAC_ID = rec.DOITAC_ID,SOLUONG = SOLUONG + (rec.SOLUONGDEXUAT - rec.SOLUONG_OLD),TRANGTHAI_BAK = TRANGTHAI, TRANGTHAI = 2 where ID = rec.TUYENKENH_ID and DELETED = 0;
		PROC_INSERT_LICHSU_TUYENKENH(usercreate_,rec.TUYENKENH_ID,3,'');
		if(rec.DUPLICATE is not null) then --duplicate => update tuyenkenhdexuat
			update TUYENKENHDEXUAT set SOLUONG = rec.SOLUONGDEXUAT,NGAYDENGHIBANGIAO = rec.NGAYDENGHIBANGIAO,NGAYHENBANGIAO = rec.NGAYHENBANGIAO,THONGTINLIENHE = rec.THONGTINLIENHE where ID = rec.DUPLICATE;
			i := rec.ID;
			str := '<root><element><id>'||i||'</id></element></root>';
			PROC_INSERT_LICHSU_TUYENKENH(usercreate_,rec.TUYENKENH_ID,8,str);
		else --insert
			i:=SEQ_TUYENKENHDEXUAT.nextval;
			insert into TUYENKENHDEXUAT(ID, DEXUAT_ID, TUYENKENH_ID, BANGIAO_ID, NGAYDENGHIBANGIAO, NGAYHENBANGIAO, THONGTINLIENHE, TRANGTHAI, SOLUONG) values (i, NULL, rec.TUYENKENH_ID, NULL, rec.NGAYDENGHIBANGIAO, rec.NGAYHENBANGIAO, rec.THONGTINLIENHE, 0, rec.SOLUONGDEXUAT);
			str := '<root><element><id>'||i||'</id></element></root>';
			PROC_INSERT_LICHSU_TUYENKENH(usercreate_,rec.TUYENKENH_ID,6,str);
		end if;
		delete from TUYENKENHDEXUAT_IMPORT where ID = rec.ID;
	end loop;
END PROC_IMPORT_TUYENKENHDEXUAT;

/


--------------------------------------------------------
--  DDL for Procedure SAVE_TUYENKENHDEXUAT_IMPORT
--------------------------------------------------------
set define off;

  CREATE OR REPLACE PROCEDURE "THUEKENH"."SAVE_TUYENKENHDEXUAT_IMPORT" (
stt_ in NUMBER,
madiemdau_ in VARCHAR2,
madiemcuoi_ in VARCHAR2,
giaotiep_ma_ in VARCHAR2,
duan_ma_ in VARCHAR2,
donvinhankenh_ma_ in VARCHAR2,
doitac_ma_ in VARCHAR2,
dungluong_ in VARCHAR2,
soluongdexuat_ in VARCHAR2,
ngayhenbangiao_ in VARCHAR2,
ngaydenghibangiao_ in VARCHAR2,
thongtinlienhe_  in VARCHAR2,
duplicate_ in VARCHAR2,
tuyenkenh_id_ in varchar2,
soluong_old_ in varchar2
) AS
i INTEGER := 0;
BEGIN
    i:=SEQ_TUYENKENHDEXUAT_IMPORT.nextval;
    --test(to_char(thoidiembatdau_,'DD-MON-YYYY HH24:MI'));
    
    insert into TUYENKENHDEXUAT_IMPORT(ID,STT,MADIEMDAU,MADIEMCUOI,GIAOTIEP_MA,DUAN_MA,DONVINHANKENH_MA,DOITAC_MA,DUNGLUONG,SOLUONGDEXUAT,NGAYHENBANGIAO,NGAYDENGHIBANGIAO,THONGTINLIENHE,DUPLICATE,TUYENKENH_ID,SOLUONG_OLD) 
    values (i,stt_,madiemdau_,madiemcuoi_,giaotiep_ma_,duan_ma_,donvinhankenh_ma_,doitac_ma_,dungluong_,soluongdexuat_,ngayhenbangiao_,ngaydenghibangiao_,thongtinlienhe_,duplicate_,tuyenkenh_id_,soluong_old_);
END SAVE_TUYENKENHDEXUAT_IMPORT;

/

--------------------------------------------------------
--  DDL for Function FIND_TUYENKENHDEXUATIMPORT
--------------------------------------------------------

  CREATE OR REPLACE FUNCTION "THUEKENH"."FIND_TUYENKENHDEXUATIMPORT" (
iDisplayStart IN NUMBER,   
iDisplayLength IN NUMBER
) RETURN SYS_REFCURSOR AS
l_cursor SYS_REFCURSOR;
v_vcsql VARCHAR2(2000);
i NUMBER;
BEGIN
	v_vcsql := 'select rownum as rn,dulieu.* from (SELECT t.ID,t.DUPLICATE,t.STT,t.MADIEMDAU,t.MADIEMCUOI,t.DUNGLUONG,t.SOLUONGDEXUAT,t.NGAYHENBANGIAO,t.NGAYDENGHIBANGIAO,t.THONGTINLIENHE,t0.LOAIGIAOTIEP,t1.TENPHONGBAN,t2.TENDOITAC,t3.TENDUAN FROM TUYENKENHDEXUAT_IMPORT t
		left join LOAIGIAOTIEP t0 on t.GIAOTIEP_MA = t0.MA
		left join PHONGBAN t1 on t.DONVINHANKENH_MA = t1.MA
		left join DOITAC t2 on t.DOITAC_MA = t2.MA
    left join DUAN t3 on t.DUAN_MA = t3.MA order by t.STT) dulieu ';
	v_vcsql := 'SELECT * FROM (' || v_vcsql || ') WHERE rn > ' || iDisplayStart || ' and rn <= ' || (iDisplayStart+iDisplayLength);
	--dbms_output.put_line(v_vcsql);
 --test(v_vcsql);
	OPEN l_cursor FOR v_vcsql;
	RETURN l_cursor;
END FIND_TUYENKENHDEXUATIMPORT;

/


