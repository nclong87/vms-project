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

