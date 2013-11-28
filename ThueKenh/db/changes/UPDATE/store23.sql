CREATE OR REPLACE PROCEDURE "THUEKENH"."PROC_SCHEDULE" AS
v_sms_content varchar2(5000);
v_phone varchar2(20);
v_tuyenkenh_ids varchar2(2000) := '';
pi_array TABLE_VARCHAR := TABLE_VARCHAR();
i number := 1;
BEGIN
  -- Kiem tra xem de xuat nao da den han ban giao nhung chua ban giao xong
  for rec in (select t.ID,t.TUYENKENH_ID from TUYENKENHDEXUAT t left join TUYENKENH t1 on t.TUYENKENH_ID=t1.ID
where t.DELETED = 0 and t.NGAYHENBANGIAO < sysdate and t.TRANGTHAI = 0 and t.FLAG_SENDMAIL is null) loop
    --SEND_SMS(rec.TUYENKENH_ID,2,null);
    --SEND_EMAIL(rec.TUYENKENH_ID,2,null);
    pi_array.extend();
    pi_array(i) := rec.TUYENKENH_ID;
    i := i + 1;
    update TUYENKENHDEXUAT set FLAG_SENDMAIL = 1 where ID = rec.ID;
  end loop;
  v_sms_content := '';
  v_phone:= ' ';
  i:= 0;
  for rec in (select phone,dl.ID as TUYENKENH_ID from accounts t0 right join (select phongban_id,t1.khuvuc_id,t0.ID,ACCOUNT_ID  from TUYENKENH t0 left join doitac t1 on t0.DOITAC_ID = t1.ID  left join account_khuvuc t2 on t2.KHUVUC_ID =t1.khuvuc_id
where t0.ID in ((select * from table(pi_array)))) dl on t0.id=dl.ACCOUNT_ID and t0.IDPHONGBAN = dl.phongban_id
where t0.active=1 and phone is not null order by phone) loop
    if(v_phone = rec.phone) then
      v_sms_content := v_sms_content || rec.TUYENKENH_ID ||',';
    else     
      if(v_phone != ' ' AND i < 1000) then
        insert into sms values (sysdate,v_phone,'Tuyen kenh den deadline nhung chua ban giao: '||v_sms_content,2); 
        INSERT INTO SMS_QUEUE@SMS6(ID, CALLLED_NUMBER,SMS_CONTENT,REQUEST_DATE_TIME,SMS_TYPE,STATUS,SCHEDULE_DATE_TIME,USER_NAME,PC,SMSC_CODE)
        VALUES(SMS_QUEUE_SEQ.NEXTVAL@SMS6, v_phone, 'Tuyen kenh den deadline nhung chua ban giao: '||v_sms_content, sysdate, 0, 0, sysdate, 'SYSTEM', '10.18.18.52','NOIMANG');
		i := i + 1;
        --dbms_output.put_line('Tuyen kenh den deadline nhung chua ban giao: '||v_sms_content);
        v_sms_content := '';
      end if;
      v_phone := rec.phone;
      v_sms_content := v_sms_content || rec.TUYENKENH_ID ||',';
    end if;  
  end loop;
  if(v_phone != ' ') then
    insert into sms values (sysdate,v_phone,'Tuyen kenh den deadline nhung chua ban giao: '||v_sms_content,2);   
    INSERT INTO SMS_QUEUE@SMS6(ID, CALLLED_NUMBER,SMS_CONTENT,REQUEST_DATE_TIME,SMS_TYPE,STATUS,SCHEDULE_DATE_TIME,USER_NAME,PC,SMSC_CODE)
    VALUES(SMS_QUEUE_SEQ.NEXTVAL@SMS6, v_phone, 'Tuyen kenh den deadline nhung chua ban giao: '||v_sms_content, sysdate, 0, 0, sysdate, 'SYSTEM', '10.18.18.52','NOIMANG');
    --dbms_output.put_line('Tuyen kenh den deadline nhung chua ban giao: '||v_sms_content);
  end if;
  
  
  -- Send sms nhac nho user dai chua login vao he thong trong vong 2 ngay
  for rec in (select t0.* from accounts t0 left join phongban t1 on t0.idphongban = t1.id where t0.NO_SMS = 0 AND t0.ACTIVE = 1 AND (login_time is null or login_time <= sysdate - 2) and t1.ma != 'KTKT' and t0.phone is not null) loop
    v_sms_content := 'Da 3 ngay, user '||rec.username|| ' khong cap nhat su co truyen dan thue, vui long cap nhat su co, neu khong co su co nao xay ra, vui long bo qua sms nay';
    insert into sms values (sysdate,rec.phone,v_sms_content,4);
    INSERT INTO SMS_QUEUE@SMS6(ID, CALLLED_NUMBER,SMS_CONTENT,REQUEST_DATE_TIME,SMS_TYPE,STATUS,SCHEDULE_DATE_TIME,USER_NAME,PC,SMSC_CODE)
    VALUES(SMS_QUEUE_SEQ.NEXTVAL@SMS6, rec.phone, v_sms_content, sysdate, 0, 0, sysdate, 'SYSTEM', '10.18.18.52','NOIMANG');
  end loop;

      -- Cap nhat trang thai ho so thanh toan
  for rec in (select t0.ID,t1.* from THANHTOAN t0 left join v_hoso_thanhtoan t1 on t0.SOHOSO = t1.mahoso where t0.deleted = 0 and t0.trangthai != 1) loop
    update THANHTOAN set trangthai = 1 where ID = rec.ID;
    --insert into THANHTOAN_INFO(THANHTOAN_ID,DELETED,MSNHANVIEN,HOTENNHANVIEN,MSHOSO,MAHOSO,MSNHANVIENNOPHS,SOTIEN,NGAYNOP,MAPHONGBAN,SOTIENTHUC,NGAYTRAHS,NGAYNHANLAI,SOCHUNGTU,KTV,KTT,BGD,SOCT,NGAYCT) VALUES (rec.ID,0, rec.MSNHANVIEN, rec.HOTENNHANVIEN, rec.MSHOSO, rec.MAHOSO, rec.MSNHANVIENNOPHS, rec.SOTIEN, rec.NGAYNOP, rec.MAPHONGBAN, rec.SOTIENTHUC, rec.NGAYTRAHS, rec.NGAYNHANLAI, rec.SOCHUNGTU, rec.KTV, rec.KTT, rec.BGD, rec.SOCT, rec.NGAYCT);

    insert into THANHTOAN_INFO(THANHTOAN_ID,DELETED,MSNHANVIEN,HOTENNHANVIEN,MSHOSO,MAHOSO,MSNHANVIENNOPHS,SOTIEN,NGAYNOP,MAPHONGBAN,SOTIENTHUC,NGAYTRAHS,NGAYNHANLAI,SOCHUNGTU,KTV,KTT,BGD,SOCT,NGAYCT,SOUNC,SOPHIEUCHI,NGAYXULY) VALUES (rec.ID,0, rec.MSNHANVIEN, rec.HOTENNHANVIEN, rec.MSHOSO, rec.MAHOSO, rec.MSNHANVIENNOPHS, rec.SOTIEN, rec.NGAYNOP, rec.MAPHONGBAN, rec.SOTIENTHUC, rec.NGAYTRAHS, rec.NGAYNHANLAI, rec.SOCHUNGTU, rec.KTV, rec.KTT, rec.BGD, rec.SOCT, rec.NGAYCT,rec.SOUNC,rec.SOPHIEUCHI,rec.NGAYXULY);

  end loop;
  INSERT INTO SMS_QUEUE@SMS6(ID, CALLLED_NUMBER,SMS_CONTENT,REQUEST_DATE_TIME,SMS_TYPE,STATUS,SCHEDULE_DATE_TIME,USER_NAME,PC,SMSC_CODE)
    VALUES(SMS_QUEUE_SEQ.NEXTVAL@SMS6, '932337487', 'Finish schedule jobs', sysdate, 0, 0, sysdate, 'SYSTEM', '10.18.18.52','NOIMANG');
END PROC_SCHEDULE;