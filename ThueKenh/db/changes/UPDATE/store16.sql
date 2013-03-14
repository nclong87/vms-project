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
  for rec in (select t0.* from accounts t0 left join phongban t1 on t0.idphongban = t1.id where (login_time is null or login_time <= sysdate - 2) and t1.ma != 'KTKT' and t0.phone is not null) loop
    v_sms_content := '[Quan ly kenh thue] SMS nhac nho user '||rec.username|| ' nhap su co';
    insert into sms values (sysdate,rec.phone,v_sms_content,4);
    INSERT INTO SMS_QUEUE@SMS6(ID, CALLLED_NUMBER,SMS_CONTENT,REQUEST_DATE_TIME,SMS_TYPE,STATUS,SCHEDULE_DATE_TIME,USER_NAME,PC,SMSC_CODE)
    VALUES(SMS_QUEUE_SEQ.NEXTVAL@SMS6, rec.phone, v_sms_content, sysdate, 0, 0, sysdate, 'SYSTEM', '10.18.18.52','NOIMANG');
  end loop;

  -- Cap nhat trang thai ho so thanh toan
END PROC_SCHEDULE;

/

