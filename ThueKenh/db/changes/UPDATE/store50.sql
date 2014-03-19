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
  p_sms_content := SUBSTR(v_sms_content,0,138);
  SEND_SMS_BRANCH(v_phone,p_sms_content,'DDH-QLTD',null);
  --SEND_SMS_TK(v_phone,p_sms_content);
  --INSERT INTO SMS_QUEUE@SMS6(ID, CALLLED_NUMBER,SMS_CONTENT,REQUEST_DATE_TIME,SMS_TYPE,STATUS,SCHEDULE_DATE_TIME,USER_NAME,PC,SMSC_CODE) VALUES(SMS_QUEUE_SEQ.NEXTVAL@SMS6, v_phone,p_sms_content, sysdate, 0, 0, sysdate, 'SYSTEM', '10.18.18.52','NOIMANG');
END PROC_SEND_SMS;

/

--------------------------------------------------------
--  DDL for Procedure PROC_INSERT_SMS
--------------------------------------------------------
set define off;

  CREATE OR REPLACE PROCEDURE "THUEKENH"."PROC_INSERT_SMS" (tuyenkenh_id_ in varchar2,type_ in number) AS
p_madiemdau varchar2(20);
p_madiemcuoi varchar2(20);
p_loaigiaotiep varchar2(200);
p_dungluong number;
p_usercreate varchar2(200);
p_tendoidoitac varchar2(200);
p_content varchar2(500);
BEGIN
  select t0.MADIEMDAU,t0.MADIEMCUOI,t1.LOAIGIAOTIEP,t0.DUNGLUONG,t0.USERCREATE,t2.TENDOITAC into p_madiemdau,p_madiemcuoi,p_loaigiaotiep,p_dungluong,p_usercreate,p_tendoidoitac FROM tuyenkenh t0 left join loaigiaotiep t1 on t0.GIAOTIEP_ID=t1.ID left join DOITAC t2 on t2.ID = t0.DOITAC_ID where t0.id = tuyenkenh_id_;
  p_content := p_madiemdau || '-' || p_madiemcuoi || '-' || p_loaigiaotiep || '-' || p_dungluong || 'M-' || p_tendoidoitac;

  -- send sms den nguoi tao tuyen kenh
  for rec in (select t1.phone,t1.email from v_sts_sys_users t1 where t1.IS_SMS_LEASELINE = 'Y' AND t1.username = p_usercreate) loop
      if(rec.phone is not null) then
          insert into sms_user (PHONE_NUMBER,TUYENKENH_ID,TYPE,CREATE_TIME,CONTENT) values (rec.phone,tuyenkenh_id_,type_,sysdate,p_content);
      end if;
  end loop;

  -- send sms den user phu trach tuyen kenh
  if(p_madiemdau is not null) then
    for rec in (select t0.username,t1.phone,t1.email from v_sts_sys_user_area t0 left join v_sts_sys_users t1 on t0.username = t1.username
where t1.IS_SMS_LEASELINE = 'Y' AND INSTR(p_madiemdau,t0.code,1) > 0) loop
      if(rec.phone is not null) then
          insert into sms_user (PHONE_NUMBER,TUYENKENH_ID,TYPE,CREATE_TIME,CONTENT) values (rec.phone,tuyenkenh_id_,type_,sysdate,p_content);
      end if;
    end loop;
  end if;
  if(p_madiemcuoi is not null) then
    for rec in (select t0.username,t1.phone,t1.email from v_sts_sys_user_area t0 left join v_sts_sys_users t1 on t0.username = t1.username
where t1.IS_SMS_LEASELINE = 'Y' AND INSTR(p_madiemcuoi,t0.code,1) > 0) loop
      if(rec.phone is not null) then
          insert into sms_user (PHONE_NUMBER,TUYENKENH_ID,TYPE,CREATE_TIME,CONTENT) values (rec.phone,tuyenkenh_id_,type_,sysdate,p_content);
      end if;
    end loop;
  end if;
  COMMIT;
END PROC_INSERT_SMS;

/

--------------------------------------------------------
--  DDL for Procedure PROC_INSERT_SMS_SUCO
--------------------------------------------------------
set define off;

  CREATE OR REPLACE PROCEDURE "THUEKENH"."PROC_INSERT_SMS_SUCO" (suco_id_ in number,type_ in number) AS
p_tuyenkenhid varchar2(20);
p_madiemdau varchar2(20);
p_madiemcuoi varchar2(20);
p_loaigiaotiep varchar2(200);
p_dungluong number;
p_usercreate varchar2(200);
p_userinput varchar2(200);
p_tendoidoitac varchar2(200);
p_content varchar2(500);
BEGIN
  select t1.MADIEMDAU,t1.MADIEMCUOI,t2.LOAIGIAOTIEP,t1.DUNGLUONG,t1.USERCREATE,t0.USERCREATE,t0.TUYENKENH_ID,t3.TENDOITAC into p_madiemdau,p_madiemcuoi,p_loaigiaotiep,p_dungluong,p_usercreate,p_userinput,p_tuyenkenhid,p_tendoidoitac FROM SUCOKENH t0 left join tuyenkenh t1 on t0.TUYENKENH_ID = t1.ID left join loaigiaotiep t2 on t1.GIAOTIEP_ID=t2.ID left join DOITAC t3 on t3.ID = t1.DOITAC_ID where t0.id = suco_id_;
  p_content := p_madiemdau || '-' || p_madiemcuoi || '-' || p_loaigiaotiep || '-' || p_dungluong || 'M-' || p_tendoidoitac || '-baocao:' || p_userinput;

  -- send sms den nguoi tao tuyen kenh va nguoi nhap su co
  for rec in (select t1.phone,t1.email from v_sts_sys_users t1 where t1.IS_SMS_LEASELINE = 'Y' AND (t1.username = p_usercreate  OR t1.username = p_userinput)) loop
      if(rec.phone is not null) then
          insert into sms_user (PHONE_NUMBER,TUYENKENH_ID,TYPE,CREATE_TIME,CONTENT) values (rec.phone,p_tuyenkenhid,type_,sysdate,p_content);
      end if;
  end loop;

  -- send sms den user phu trach tuyen kenh
  if(p_madiemdau is not null) then
    for rec in (select t0.username,t1.phone,t1.email from v_sts_sys_user_area t0 left join v_sts_sys_users t1 on t0.username = t1.username
where t1.IS_SMS_LEASELINE = 'Y' AND INSTR(p_madiemdau,t0.code,1) > 0) loop
      if(rec.phone is not null) then
          insert into sms_user (PHONE_NUMBER,TUYENKENH_ID,TYPE,CREATE_TIME,CONTENT) values (rec.phone,p_tuyenkenhid,type_,sysdate,p_content);
      end if;
    end loop;
  end if;
  if(p_madiemcuoi is not null) then
    for rec in (select t0.username,t1.phone,t1.email from v_sts_sys_user_area t0 left join v_sts_sys_users t1 on t0.username = t1.username
where t1.IS_SMS_LEASELINE = 'Y' AND INSTR(p_madiemcuoi,t0.code,1) > 0) loop
      if(rec.phone is not null) then
          insert into sms_user (PHONE_NUMBER,TUYENKENH_ID,TYPE,CREATE_TIME,CONTENT) values (rec.phone,p_tuyenkenhid,type_,sysdate,p_content);
      end if;
    end loop;
  end if;
  NULL;
END PROC_INSERT_SMS_SUCO;

/

--------------------------------------------------------
--  DDL for Procedure PROC_CRON_SMS
--------------------------------------------------------
set define off;

  CREATE OR REPLACE PROCEDURE "THUEKENH"."PROC_CRON_SMS" AS
TYPE sms_content IS TABLE OF VARCHAR2(1000);
TYPE array_smscontent IS TABLE OF sms_content;
v_sms_content array_smscontent;
v_phone varchar2(20);
i number := 1;
j number := 1;
which VARCHAR2(1000);
v_content varchar(200);
n number := 1;
nMax number := 5000;
BEGIN
  i:= 0;
  FOR rec in (select distinct phone_number from sms_user where CREATE_TIME >= SYSDATE - 1 and phone_number is not null) loop
      v_sms_content := array_smscontent();
      v_sms_content.extend(10);
      v_sms_content(1) := sms_content();
      v_sms_content(1).EXTEND;
      v_sms_content(2) := sms_content();
      v_sms_content(2).EXTEND;
      v_sms_content(3) := sms_content();
      v_sms_content(3).EXTEND;
      v_sms_content(7) := sms_content();
      v_sms_content(7).EXTEND;
      v_sms_content(8) := sms_content();
      v_sms_content(8).EXTEND;
      v_sms_content(9) := sms_content();
      v_sms_content(9).EXTEND;
      for rec2 in (select tuyenkenh_id,type,content from sms_user where content is not null AND CREATE_TIME >= SYSDATE - 1 and phone_number = rec.phone_number group by tuyenkenh_id,type,content) loop
          i := v_sms_content(rec2.type).count;
          which := v_sms_content(rec2.type)(i);
          which := which || ' ' || rec2.content;
          if(LENGTH(which) < 109) then
            v_sms_content(rec2.type)(i) := which;
          else
            v_sms_content(rec2.type).EXTEND;
            i := v_sms_content(rec2.type).count;
            v_sms_content(rec2.type)(i) := ' '||rec2.content;
          end if;
      end loop;
      for i in v_sms_content.first .. v_sms_content.last loop
        which := '';
        if(i = 1) then
          which := 'Tuyen kenh de xuat moi:';
        elsif(i = 2) then
          which := 'Qua han ban giao 7 ngay:';
        elsif(i = 3) then
          which := 'Tuyen kenh da ban giao:';
        elsif(i = 7) then
          which := 'Qua 7 ngay chua nhap bb su co:';
        elsif(i = 8) then
          which := 'Truoc han ban giao 7 ngay:';
         elsif(i = 9) then
          which := 'Hom nay ban giao:';
        end if;
        if(which is not null) then
          for j in v_sms_content(i).first .. v_sms_content(i).last loop
            if(v_sms_content(i)(j) is not null and length(v_sms_content(i)(j)) > 0) then
              if(n > nMax) then
                EXIT;
              end if;
              PROC_SEND_SMS(rec.phone_number,which || v_sms_content(i)(j),1);
              n := n + 1;
            end if;
          end loop;
        end if;
      end loop;
  end loop;
  DELETE FROM sms_user;
  COMMIT;
  PROC_SEND_SMS('932337487','You had sent ' || n || ' SMS',0);
END PROC_CRON_SMS;

/

