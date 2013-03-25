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
			where t.deleted = 0 and t.phuluc_id is not null and t.thoidiembatdau >= pFrom and t.thoidiembatdau < pEnd and t3.doitac_id = pDoiTacId;
	RETURN l_cursor;
END BC_GIAMTRUMLL;

/

CREATE TABLE THANHTOAN_INFO 
(
  THANHTOAN_ID NUMBER NOT NULL 
, DELETED NUMBER NOT NULL 
, MSNHANVIEN VARCHAR2(200) 
, HOTENNHANVIEN VARCHAR2(500) 
, MSHOSO VARCHAR2(200) 
, MAHOSO VARCHAR2(200) 
, MSNHANVIENNOPHS VARCHAR2(200) 
, SOTIEN VARCHAR2(200) 
, NGAYNOP VARCHAR2(20) 
, MAPHONGBAN VARCHAR2(200) 
, SOTIENTHUC VARCHAR2(200) 
, NGAYTRAHS VARCHAR2(200) 
, NGAYNHANLAI VARCHAR2(200) 
, SOCHUNGTU VARCHAR2(200) 
, KTV VARCHAR2(200) 
, KTT VARCHAR2(200) 
, BGD VARCHAR2(200) 
, SOCT VARCHAR2(200) 
, NGAYCT VARCHAR2(200) 
, SOUNC VARCHAR2(200) 
, SOPHIEUCHI VARCHAR2(200) 
, NGAYXULY VARCHAR2(200) 
, CONSTRAINT THANHTOAN_INFO_PK PRIMARY KEY 
  (
    THANHTOAN_ID 
  , DELETED 
  )
  ENABLE 
);


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
  for rec in (select t0.ID,t1.* from THANHTOAN t0 left join v_hoso_thanhtoan t1 on t0.SOHOSO = t1.mahoso where t0.deleted = 0 and t0.trangthai != 1) loop
    update THANHTOAN set trangthai = 1 where ID = rec.ID;
    insert into THANHTOAN_INFO(THANHTOAN_ID,DELETED,MSNHANVIEN,HOTENNHANVIEN,MSHOSO,MAHOSO,MSNHANVIENNOPHS,SOTIEN,NGAYNOP,MAPHONGBAN,SOTIENTHUC,NGAYTRAHS,NGAYNHANLAI,SOCHUNGTU,KTV,KTT,BGD,SOCT,NGAYCT,SOUNC,SOPHIEUCHI,NGAYXULY) VALUES (rec.ID,0, rec.MSNHANVIEN, rec.HOTENNHANVIEN, rec.MSHOSO, rec.MAHOSO, rec.MSNHANVIENNOPHS, rec.SOTIEN, rec.NGAYNOP, rec.MAPHONGBAN, rec.SOTIENTHUC, rec.NGAYTRAHS, rec.NGAYNHANLAI, rec.SOCHUNGTU, rec.KTV, rec.KTT, rec.BGD, rec.SOCT, rec.NGAYCT,rec.SOUNC,rec.SOPHIEUCHI,rec.NGAYXULY);
  end loop;
END PROC_SCHEDULE;

/

