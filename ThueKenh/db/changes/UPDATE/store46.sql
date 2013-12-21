CREATE TABLE V_STS_SYS_USER_AREA 
(
  USERNAME VARCHAR2(100) 
, DISTRICT VARCHAR2(100) 
, DESCRIPTION VARCHAR2(500) 
, IS_ENABLE VARCHAR2(5) 
, ORDERING VARCHAR2(20) 
, ALARM_KPI VARCHAR2(20) 
, ID VARCHAR2(20) 
);

GO

CREATE TABLE V_STS_SYS_USERS 
(
  ID VARCHAR2(20) 
, USERNAME VARCHAR2(100) 
, PASSWORD VARCHAR2(50) 
, FULLNAME VARCHAR2(100) 
, SEX VARCHAR2(20) 
, POSITION VARCHAR2(50) 
, PHONE VARCHAR2(20) 
, EMAIL VARCHAR2(50) 
, LOGIN_BY VARCHAR2(50) 
, RECEIVING_SMS VARCHAR2(50) 
, RECEIVING_EMAIL VARCHAR2(50) 
, IS_ENABLE VARCHAR2(50) 
, ACTIVE_DATE VARCHAR2(50) 
, EXPIRED VARCHAR2(50) 
, DESCRIPTION VARCHAR2(50) 
, CREATED_BY VARCHAR2(50) 
, CREATE_DATE VARCHAR2(50) 
, MODIFIED_BY VARCHAR2(50) 
, MODIFY_DATE VARCHAR2(50) 
, MA_PHONG VARCHAR2(50) 
, ROLES_ADD_USERS VARCHAR2(50) 
, CC_EMAIL VARCHAR2(50) 
, CC_SMS VARCHAR2(50)
,IS_SMS_LEASELINE VARCHAR(50)
);

go
--------------------------------------------------------
--  DDL for Procedure PROC_CRON_SMS
--------------------------------------------------------
set define off;

  CREATE OR REPLACE PROCEDURE "THUEKENH"."PROC_CRON_SMS" AS
v_sms_content varchar2(5000);
v_sms_content1 varchar2(2000);
v_sms_content2 varchar2(2000);
v_sms_content3 varchar2(2000);
v_sms_content7 varchar2(2000);
v_phone varchar2(20);
i number := 1;
BEGIN
  v_sms_content := '';
  v_phone:= ' ';
  i:= 0;
  -- Send sms nhac nho user dai chua login vao he thong trong vong 2 ngay
  /* for rec in (select t1.username,t0.phone from v_sts_sys_users t0 left join accounts t1 on t0.username = t1.username where t1.ACTIVE = 1 and t0.is_enable = 'Y' and t0.receiving_sms = 'Y' and t0.phone is not null and (login_time is null or login_time <= sysdate - 2)) loop
    v_sms_content := 'Da 3 ngay, user '||rec.username|| ' khong cap nhat su co truyen dan thue, vui long cap nhat su co, neu khong co su co nao xay ra, vui long bo qua sms nay';
    PROC_SEND_SMS(rec.phone,v_sms_content,4);
  end loop; */
  /*for rec in (select * from sucokenh where DELETED=0 and filename is null and filepath is null and filesize is null and timecreate <= sysdate-3) loop
      PROC_INSERT_SMS(rec.TUYENKENH_ID,1);
   END LOOP ;*/
  --PROC_INSERT_SMS('VTBD_0192',1);
  FOR rec in (select distinct phone_number from sms_user where CREATE_TIME >= SYSDATE - 1 and phone_number is not null) loop
      v_sms_content1 := '';
      v_sms_content2 := '';
      v_sms_content3 := '';
      v_sms_content7 := '';
      for rec2 in (select tuyenkenh_id,type from sms_user where CREATE_TIME >= SYSDATE - 1 and phone_number = rec.phone_number group by tuyenkenh_id,type) loop
        if(rec2.type = 7) then -- gui SMS su co
          v_sms_content7 := v_sms_content7 || rec2.tuyenkenh_id || ', ';
        elsif (rec2.type = 2)  then-- gui SMS Tuyen kenh den deadline nhung chua ban giao
          v_sms_content2 := v_sms_content2 || rec2.tuyenkenh_id || ', ';
        elsif (rec2.type = 1) then -- gui SMS tuyen kenh duoc de xuat moi
          v_sms_content1 := v_sms_content1 || rec2.tuyenkenh_id || ', ';
         elsif (rec2.type = 3) then -- gui SMS tuyen kenh duoc ban giao xong
          v_sms_content3 := v_sms_content3 || rec2.tuyenkenh_id || ', ';
        end if;
      end loop;
      if(v_sms_content1 is not null) then
        v_sms_content1 := 'Tuyen kenh de xuat moi: ' || v_sms_content1;
        PROC_SEND_SMS(rec.phone_number,v_sms_content1,1);
      end if;
      if(v_sms_content2 is not null) then
        v_sms_content2 := 'Tuyen kenh chua nhan sau 3 ngay ban giao: ' || v_sms_content2;
        PROC_SEND_SMS(rec.phone_number,v_sms_content2,2);
      end if;
      if(v_sms_content3 is not null) then
        v_sms_content3 := 'Tuyen kenh da ban giao: ' || v_sms_content3;
        PROC_SEND_SMS(rec.phone_number,v_sms_content3,3);
      end if;
      if(v_sms_content7 is not null) then
        v_sms_content7 := 'Qua 3 ngay chua nhap bb su co: ' || v_sms_content7;
        PROC_SEND_SMS(rec.phone_number,v_sms_content7,7);
      end if;
  end loop;
  DELETE FROM sms_user;
  COMMIT;
END PROC_CRON_SMS;

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
p_sms_content  varchar2(3000);
BEGIN
  insert into sms values (sysdate,v_phone,v_sms_content,v_type);
  p_sms_content := SUBSTR(v_sms_content,0,1000);
  SEND_SMS_BRANCH(v_phone,p_sms_content,'DDH-LEASELINE',null);
  --SEND_SMS_TK(v_phone,p_sms_content);
  --INSERT INTO SMS_QUEUE@SMS6(ID, CALLLED_NUMBER,SMS_CONTENT,REQUEST_DATE_TIME,SMS_TYPE,STATUS,SCHEDULE_DATE_TIME,USER_NAME,PC,SMSC_CODE) VALUES(SMS_QUEUE_SEQ.NEXTVAL@SMS6, v_phone,p_sms_content, sysdate, 0, 0, sysdate, 'SYSTEM', '10.18.18.52','NOIMANG');
END PROC_SEND_SMS;

/

