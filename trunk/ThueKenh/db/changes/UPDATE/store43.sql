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
  /* for rec in (select t1.username,t0.phone from v_sts_sys_users t0 left join accounts t1 on t0.username = t1.username where t1.ACTIVE = 1 and t0.is_enable = 'Y' and t0.receiving_sms = 'Y' and t0.phone is not null and (login_time is null or login_time <= sysdate - 2)) loop
    v_sms_content := 'Da 3 ngay, user '||rec.username|| ' khong cap nhat su co truyen dan thue, vui long cap nhat su co, neu khong co su co nao xay ra, vui long bo qua sms nay';
    PROC_SEND_SMS(rec.phone,v_sms_content,4);
  end loop; */
  /*for rec in (select * from sucokenh where DELETED=0 and filename is null and filepath is null and filesize is null and timecreate <= sysdate-3) loop
      PROC_INSERT_SMS(rec.TUYENKENH_ID,1);
   END LOOP ;*/
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

