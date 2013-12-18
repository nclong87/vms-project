--------------------------------------------------------
--  DDL for Procedure PROC_CRON_SMS_INIT
--------------------------------------------------------
set define off;

  CREATE OR REPLACE PROCEDURE "THUEKENH"."PROC_CRON_SMS_INIT" AS 
BEGIN
  DELETE FROM sms_user;
  COMMIT;
  NULL;
END PROC_CRON_SMS_INIT;

/

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
    for rec in (select t0.username,t1.phone,t1.email from v_sts_sys_user_area t0 left join v_sts_sys_users t1 on t0.username = t1.username
where t1.IS_SMS_LEASELINE = 'Y' AND INSTR(p_madiemdau,district,1) > 0) loop
      if(rec.phone is not null) then
          insert into sms_user (PHONE_NUMBER,TUYENKENH_ID,TYPE,CREATE_TIME) values (rec.phone,tuyenkenh_id_,type_,sysdate);
      end if;
    end loop;
  end if;
  if(p_madiemcuoi is not null) then
    for rec in (select t0.username,t1.phone,t1.email from v_sts_sys_user_area t0 left join v_sts_sys_users t1 on t0.username = t1.username
where t1.IS_SMS_LEASELINE = 'Y' AND INSTR(p_madiemcuoi,district,1) > 0) loop
      if(rec.phone is not null) then
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
  p_sms_content := SUBSTR(v_sms_content,0,3000);
  SEND_SMS_TK(v_phone,p_sms_content);
  --INSERT INTO SMS_QUEUE@SMS6(ID, CALLLED_NUMBER,SMS_CONTENT,REQUEST_DATE_TIME,SMS_TYPE,STATUS,SCHEDULE_DATE_TIME,USER_NAME,PC,SMSC_CODE) VALUES(SMS_QUEUE_SEQ.NEXTVAL@SMS6, v_phone,p_sms_content, sysdate, 0, 0, sysdate, 'SYSTEM', '10.18.18.52','NOIMANG');
END PROC_SEND_SMS;

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
      
      -- send mail/sms
      PROC_CRON_SMS_INIT();
      PROC_INSERT_SMS(tuyenkenh_id_,3);
      PROC_CRON_SMS();
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
--  DDL for Procedure PROC_SCHEDULE
--------------------------------------------------------
set define off;

  CREATE OR REPLACE PROCEDURE "THUEKENH"."PROC_SCHEDULE" AS
BEGIN
  PROC_UPDATE_HSTT();
  PROC_UPDATE_TRAM_BTS();
  PROC_SMS_DAILY();
  PROC_SEND_SMS('932337487','Finish schedule jobs',5);
END PROC_SCHEDULE;

/

--------------------------------------------------------
--  DDL for Procedure PROC_SMS_DAILY
--------------------------------------------------------
set define off;

  CREATE OR REPLACE PROCEDURE "THUEKENH"."PROC_SMS_DAILY" AS 
BEGIN
  PROC_CRON_SMS_INIT();
  -- Sau 3 ngay den han ban giao ma chua nhan kenh
  for rec in (select t.ID,t.TUYENKENH_ID from TUYENKENHDEXUAT t left join TUYENKENH t1 on t.TUYENKENH_ID=t1.ID
where t.DELETED = 0 and t.NGAYHENBANGIAO < sysdate - 3 and t.TRANGTHAI = 0 and t.FLAG_SENDMAIL is null) loop
    PROC_INSERT_SMS(rec.TUYENKENH_ID,2);
    update TUYENKENHDEXUAT set FLAG_SENDMAIL = 1 where ID = rec.ID;
  end loop;
  
  -- Su co sau 3 ngay ko co file scan
  for rec in (select * from sucokenh where DELETED=0 and filename is null and filepath is null and filesize is null and timecreate <= sysdate-3) loop
      PROC_INSERT_SMS(rec.TUYENKENH_ID,7);               
   END LOOP ;
  
  PROC_CRON_SMS();
END PROC_SMS_DAILY;

/

