--------------------------------------------------------
--  File created - Thursday-November-14-2013   
--------------------------------------------------------
--------------------------------------------------------
--  DDL for Table SMS_USER
--------------------------------------------------------

  CREATE TABLE "THUEKENH"."SMS_USER" 
   (	"PHONE_NUMBER" VARCHAR2(20 BYTE), 
	"TUYENKENH_ID" VARCHAR2(20 BYTE), 
	"TYPE" NUMBER, 
	"CREATE_TIME" DATE
   ) ;
REM INSERTING into THUEKENH.SMS_USER
--------------------------------------------------------
--  DDL for Index SMS_USER_INDEX1
--------------------------------------------------------

  CREATE INDEX "THUEKENH"."SMS_USER_INDEX1" ON "THUEKENH"."SMS_USER" ("PHONE_NUMBER") 
  ;
--------------------------------------------------------
--  Constraints for Table SMS_USER
--------------------------------------------------------

  ALTER TABLE "THUEKENH"."SMS_USER" MODIFY ("PHONE_NUMBER" NOT NULL ENABLE);
 
  ALTER TABLE "THUEKENH"."SMS_USER" MODIFY ("TUYENKENH_ID" NOT NULL ENABLE);
 
  ALTER TABLE "THUEKENH"."SMS_USER" MODIFY ("TYPE" NOT NULL ENABLE);

--------------------------------------------------------
--  DDL for Procedure PROC_INSERT_SMS
--------------------------------------------------------
set define off;

  CREATE OR REPLACE PROCEDURE "THUEKENH"."PROC_INSERT_SMS" (tuyenkenh_id_ in varchar2,type_ in number) AS 
p_madiemdau varchar2(20);
p_madiemcuoi varchar2(20);
BEGIN
  select MADIEMDAU,MADIEMCUOI into p_madiemdau,p_madiemcuoi FROM tuyenkenh where id = tuyenkenh_id_;
  if(p_madiemdau is not null) then
    for rec in (select t0.username,t1.RECEIVING_SMS,t1.receiving_email,t1.phone,t1.email from v_sts_sys_user_area t0 left join v_sts_sys_users t1 on t0.username = t1.username 
where t1.IS_ENABLE = 'Y' AND INSTR(p_madiemdau,district,1) > 0) loop
      if(rec.RECEIVING_SMS = 'Y' AND rec.phone is not null) then
          insert into sms_user (PHONE_NUMBER,TUYENKENH_ID,TYPE,CREATE_TIME) values (rec.phone,tuyenkenh_id_,type_,sysdate);
      end if;
    end loop;
  end if;
  if(p_madiemcuoi is not null) then
    for rec in (select t0.username,t1.RECEIVING_SMS,t1.receiving_email,t1.phone,t1.email from v_sts_sys_user_area t0 left join v_sts_sys_users t1 on t0.username = t1.username 
where t1.IS_ENABLE = 'Y' AND INSTR(p_madiemcuoi,district,1) > 0) loop
      if(rec.RECEIVING_SMS = 'Y' AND rec.phone is not null) then
          insert into sms_user (PHONE_NUMBER,TUYENKENH_ID,TYPE,CREATE_TIME) values (rec.phone,tuyenkenh_id_,type_,sysdate);
      end if;
    end loop;
  end if;
  NULL;
END PROC_INSERT_SMS;

/

--------------------------------------------------------
--  DDL for Procedure PROC_SEND_SMS
--------------------------------------------------------
set define off;

  CREATE OR REPLACE PROCEDURE "THUEKENH"."PROC_SEND_SMS" (
v_phone in varchar2,
v_sms_content in varchar2,
v_type in number
) AS 
p_sms_content  varchar2(900);
BEGIN
  insert into sms values (sysdate,v_phone,v_sms_content,v_type);
  p_sms_content := SUBSTR(v_sms_content,0,799);
  INSERT INTO SMS_QUEUE@SMS6(ID, CALLLED_NUMBER,SMS_CONTENT,REQUEST_DATE_TIME,SMS_TYPE,STATUS,SCHEDULE_DATE_TIME,USER_NAME,PC,SMSC_CODE) VALUES(SMS_QUEUE_SEQ.NEXTVAL@SMS6, v_phone,p_sms_content, sysdate, 0, 0, sysdate, 'SYSTEM', '10.18.18.52','NOIMANG');
END PROC_SEND_SMS;

/

--------------------------------------------------------
--  DDL for Procedure PROC_UPDATE_HSTT
--------------------------------------------------------
set define off;

  CREATE OR REPLACE PROCEDURE "THUEKENH"."PROC_UPDATE_HSTT" AS 
i number := 1;
dFrom date;
dEnd date;
nMonth number;
nYear number;
str varchar2(2000);
BEGIN
  -- Cap nhat trang thai ho so thanh toan
  for rec in (select t0.ID,t0.DOISOATCUOC_ID,t0.SOHOSO,t1.* from THANHTOAN t0 left join v_hoso_thanhtoan t1 on t0.SOHOSO = t1.mahoso where t0.deleted = 0 and t0.trangthai != 1) loop
    update THANHTOAN set trangthai = 1 where ID = rec.ID;
    --insert into THANHTOAN_INFO(THANHTOAN_ID,DELETED,MSNHANVIEN,HOTENNHANVIEN,MSHOSO,MAHOSO,MSNHANVIENNOPHS,SOTIEN,NGAYNOP,MAPHONGBAN,SOTIENTHUC,NGAYTRAHS,NGAYNHANLAI,SOCHUNGTU,KTV,KTT,BGD,SOCT,NGAYCT) VALUES (rec.ID,0, rec.MSNHANVIEN, rec.HOTENNHANVIEN, rec.MSHOSO, rec.MAHOSO, rec.MSNHANVIENNOPHS, rec.SOTIEN, rec.NGAYNOP, rec.MAPHONGBAN, rec.SOTIENTHUC, rec.NGAYTRAHS, rec.NGAYNHANLAI, rec.SOCHUNGTU, rec.KTV, rec.KTT, rec.BGD, rec.SOCT, rec.NGAYCT);

    insert into THANHTOAN_INFO(THANHTOAN_ID,DELETED,MSNHANVIEN,HOTENNHANVIEN,MSHOSO,MAHOSO,MSNHANVIENNOPHS,SOTIEN,NGAYNOP,MAPHONGBAN,SOTIENTHUC,NGAYTRAHS,NGAYNHANLAI,SOCHUNGTU,KTV,KTT,BGD,SOCT,NGAYCT,SOUNC,SOPHIEUCHI,NGAYXULY) VALUES (rec.ID,0, rec.MSNHANVIEN, rec.HOTENNHANVIEN, rec.MSHOSO, rec.MAHOSO, rec.MSNHANVIENNOPHS, rec.SOTIEN, rec.NGAYNOP, rec.MAPHONGBAN, rec.SOTIENTHUC, rec.NGAYTRAHS, rec.NGAYNHANLAI, rec.SOCHUNGTU, rec.KTV, rec.KTT, rec.BGD, rec.SOCT, rec.NGAYCT,rec.SOUNC,rec.SOPHIEUCHI,rec.NGAYXULY);
	update SUCOKENH SET TRANGTHAI = 1 WHERE THANHTOAN_ID = rec.ID;

	select TUNGAY,DENNGAY into dFrom,dEnd from DOISOATCUOC where id =  rec.DOISOATCUOC_ID;
    for rec2 in (select t.* from PHULUC t left join DOISOATCUOC_PHULUC t1 on t.ID = t1.PHULUC_ID where t.TRANGTHAI != 1 AND DOISOATCUOC_ID = rec.DOISOATCUOC_ID) loop
		nMonth := extract(month from dFrom);
		nYear := extract(year from dFrom);
		if(rec2.NGAYHETHIEULUC is not null AND rec2.NGAYHETHIEULUC <= dEnd) then --phu luc het hieu luc
		  nMonth := extract(month from rec2.NGAYHETHIEULUC);
		  nYear := extract(year from rec2.NGAYHETHIEULUC);
		  update PHULUC set TRANGTHAI = 1 where ID = rec2.ID;
		end if;
		update PHULUC set THANG = nMonth,NAM = nYear where ID = rec2.ID;
		str := '<root><element><sohoso_id>'||rec.ID||'</sohoso_id><sohoso>'||rec.SOHOSO||'</sohoso><thang>'||nMonth||'</thang><nam>'||nYear||'</nam></element></root>';
		PROC_INSERT_LICHSU_PHULUC('SYSTEM',rec2.ID,6,str);
		str := '<root><element><sohoso_id>'||rec.ID||'</sohoso_id><sohoso>'||rec.SOHOSO||'</sohoso></element></root>';
		for rec3 in (select * from CHITIETPHULUC_TUYENKENH where PHULUC_ID = rec2.ID) loop
		  PROC_INSERT_LICHSU_TUYENKENH('SYSTEM',rec3.TUYENKENH_ID,5,str);
		end loop;
    end loop;
  end loop;
END PROC_UPDATE_HSTT;

/

--------------------------------------------------------
--  DDL for Procedure PROC_CRON_SMS
--------------------------------------------------------
set define off;

  CREATE OR REPLACE PROCEDURE "THUEKENH"."PROC_CRON_SMS" AS 
v_sms_content varchar2(5000);
v_sms_content1 varchar2(900);
v_sms_content2 varchar2(900);
v_phone varchar2(20);
i number := 1;
BEGIN
  DELETE FROM sms_user;
  COMMIT;
  -- Kiem tra xem de xuat nao da den han ban giao nhung chua ban giao xong
  for rec in (select t.ID,t.TUYENKENH_ID from TUYENKENHDEXUAT t left join TUYENKENH t1 on t.TUYENKENH_ID=t1.ID
where t.DELETED = 0 and t.NGAYHENBANGIAO < sysdate and t.TRANGTHAI = 0 and t.FLAG_SENDMAIL is null) loop
	PROC_INSERT_SMS(rec.TUYENKENH_ID,2);
    update TUYENKENHDEXUAT set FLAG_SENDMAIL = 1 where ID = rec.ID;
  end loop;
  v_sms_content := '';
  v_phone:= ' ';
  i:= 0;
  -- Send sms nhac nho user dai chua login vao he thong trong vong 2 ngay
  for rec in (select t1.username,t0.phone from v_sts_sys_users t0 left join accounts t1 on t0.username = t1.username where t1.ACTIVE = 1 and t0.is_enable = 'Y' and t0.receiving_sms = 'Y' and t0.phone is not null and (login_time is null or login_time <= sysdate - 2)) loop
    v_sms_content := 'Da 3 ngay, user '||rec.username|| ' khong cap nhat su co truyen dan thue, vui long cap nhat su co, neu khong co su co nao xay ra, vui long bo qua sms nay';
    PROC_SEND_SMS(rec.phone,v_sms_content,4);
  end loop;
  for rec in (select * from sucokenh where DELETED=0 and filename is null and filepath is null and filesize is null and timecreate <= sysdate-3) loop
      PROC_INSERT_SMS(rec.TUYENKENH_ID,1);               
   END LOOP ;
  --PROC_INSERT_SMS('VTBD_0192',1);
  COMMIT;
  FOR rec in (select distinct phone_number from sms_user where CREATE_TIME >= SYSDATE - 1 and phone_number is not null) loop
      v_sms_content1 := '';
      v_sms_content2 := '';
      for rec2 in (select tuyenkenh_id,type from sms_user where CREATE_TIME >= SYSDATE - 1 and phone_number = rec.phone_number group by tuyenkenh_id,type) loop
        if(rec2.type = 1) then -- gui SMS su co
          v_sms_content1 := v_sms_content1 || rec2.tuyenkenh_id || ', ';
        elsif (rec2.type = 2)  then-- gui SMS Tuyen kenh den deadline nhung chua ban giao
          v_sms_content2 := v_sms_content2 || rec2.tuyenkenh_id || ', ';
        end if;
      end loop;
      if(v_sms_content1 is not null) then
        v_sms_content1 := 'Tuyen kenh chua co bien ban su co: ' || v_sms_content1;
        PROC_SEND_SMS(rec.phone_number,v_sms_content1,1);
      end if;
      if(v_sms_content2 is not null) then
        v_sms_content2 := 'Tuyen kenh den deadline nhung chua ban giao: ' || v_sms_content2;
        PROC_SEND_SMS(rec.phone_number,v_sms_content2,2);
      end if;
  end loop;
  DELETE FROM sms_user;
  COMMIT;
END PROC_CRON_SMS;

/

--------------------------------------------------------
--  DDL for Procedure PROC_SCHEDULE
--------------------------------------------------------
set define off;

  CREATE OR REPLACE PROCEDURE "THUEKENH"."PROC_SCHEDULE" AS
BEGIN
  PROC_UPDATE_HSTT();
  PROC_UPDATE_TRAM_BTS();
  PROC_CRON_SMS();
  PROC_SEND_SMS('932337487','Finish schedule jobs',5);
END PROC_SCHEDULE;

/




