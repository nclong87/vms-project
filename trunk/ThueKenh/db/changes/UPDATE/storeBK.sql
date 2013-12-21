--------------------------------------------------------
--  DDL for Procedure PROC_CRON_SMS
--------------------------------------------------------
set define off;

  CREATE OR REPLACE PROCEDURE "THUEKENH"."PROC_CRON_SMS" AS
TYPE sms_content IS TABLE OF VARCHAR2(200);
TYPE array_smscontent IS TABLE OF sms_content;
v_sms_content array_smscontent;
v_phone varchar2(20);
i number := 1;
j number := 1;
which VARCHAR2(200);
v_content varchar(200);
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
          if(LENGTH(which) < 140) then
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
          which := 'Qua han ban giao 3 ngay:';
        elsif(i = 3) then
          which := 'Tuyen kenh da ban giao:';
        elsif(i = 7) then
          which := 'Qua 3 ngay chua nhap bb su co:';
        elsif(i = 8) then
          which := 'Truoc han ban giao 3 ngay:';
         elsif(i = 9) then
          which := 'Hom nay ban giao:';
        end if;
        if(which is not null) then          
          for j in v_sms_content(i).first .. v_sms_content(i).last loop
            if(v_sms_content(i)(j) is not null and length(v_sms_content(i)(j)) > 0) then
              PROC_SEND_SMS(rec.phone_number,which || v_sms_content(i)(j),1);
            end if;           
          end loop;
        end if;
      end loop;
  end loop;
  DELETE FROM sms_user;
  COMMIT;
END PROC_CRON_SMS;

/

