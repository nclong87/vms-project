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
  p_content := p_madiemdau || '-' || p_madiemcuoi || '-' || p_loaigiaotiep || '-' || p_dungluong || 'M-' || p_tendoidoitac || '-dexuat:' || p_usercreate || '-baocao:' || p_userinput;
  
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
  p_content := p_madiemdau || '-' || p_madiemcuoi || '-' || p_loaigiaotiep || '-' || p_dungluong || 'M-' || p_tendoidoitac ||'-dexuat:' || p_usercreate;
  
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

