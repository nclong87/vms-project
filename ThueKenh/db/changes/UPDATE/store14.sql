--------------------------------------------------------
--  DDL for Function SAVE_TUYENKENHDEXUAT
--------------------------------------------------------

  CREATE OR REPLACE FUNCTION "THUEKENH"."SAVE_TUYENKENHDEXUAT" (
id_ in VARCHAR2,
tuyenkenh_id_ in VARCHAR2,
madiemdau_ in VARCHAR2,
madiemcuoi_ in VARCHAR2,
giaotiep_id_ in VARCHAR2,
duan_id_ in VARCHAR2,
phongban_id_ in VARCHAR2,
doitac_id_ in VARCHAR2,
dungluong_ in VARCHAR2,
ngaydenghibangiao_ in VARCHAR2,
ngayhenbangiao_ in VARCHAR2,
thongtinlienhe_ in VARCHAR2,
soluong_ in NUMBER,
soluong_old in NUMBER,
usercreate_ in VARCHAR2,
timecreate_ in VARCHAR2
) RETURN NUMBER AS
i INTEGER := 0;
madoitac varchar2(50);
matuyenkenh varchar2(20);
id_tuyenkenh varchar2(50);
str varchar2(500) := '';
BEGIN
	if(tuyenkenh_id_ is not null) then --update
		update TUYENKENH set DUAN_ID = duan_id_,PHONGBAN_ID = phongban_id_,DOITAC_ID = doitac_id_,DUNGLUONG = dungluong_,SOLUONG = SOLUONG + (soluong_ - soluong_old),TRANGTHAI_BAK = TRANGTHAI, TRANGTHAI = 2  where ID = tuyenkenh_id_ and DELETED = 0;
		id_tuyenkenh := tuyenkenh_id_;
    PROC_INSERT_LICHSU_TUYENKENH(usercreate_,id_tuyenkenh,3,'');
	else --insert
		i:=GET_SOTUYENKENH(doitac_id_) + 1;
    select ma into madoitac from doitac where id = doitac_id_;
    id_tuyenkenh := FN_GEN_MATUYENKENH(doitac_id_,madoitac);
		insert into TUYENKENH(ID, MADIEMDAU, MADIEMCUOI, GIAOTIEP_ID, DUAN_ID, PHONGBAN_ID, DOITAC_ID, DUNGLUONG, SOLUONG, TRANGTHAI, USERCREATE, TIMECREATE, DELETED) values (id_tuyenkenh, madiemdau_, madiemcuoi_, giaotiep_id_, duan_id_, phongban_id_, doitac_id_, dungluong_, soluong_, 1, usercreate_, timecreate_, 0);
		PROC_INSERT_LICHSU_TUYENKENH(usercreate_,id_tuyenkenh,1,'');
	end if;
	if(id_ is not null and id_>0) then --update
		update TUYENKENHDEXUAT set TUYENKENH_ID = id_tuyenkenh,NGAYDENGHIBANGIAO = ngaydenghibangiao_,NGAYHENBANGIAO = ngayhenbangiao_,THONGTINLIENHE = thongtinlienhe_,SOLUONG = soluong_ where ID = id_;
		i := id_;
		str := '<root><element><id>'||i||'</id></element></root>';
		PROC_INSERT_LICHSU_TUYENKENH(usercreate_,id_tuyenkenh,8,str);
	else --insert
		i:=SEQ_TUYENKENHDEXUAT.nextval;
		insert into TUYENKENHDEXUAT(ID, DEXUAT_ID, TUYENKENH_ID, BANGIAO_ID, NGAYDENGHIBANGIAO, NGAYHENBANGIAO, THONGTINLIENHE, TRANGTHAI, SOLUONG) values (i, NULL, id_tuyenkenh, NULL, ngaydenghibangiao_, ngayhenbangiao_, thongtinlienhe_, 0, soluong_);
		str := '<root><element><id>'||i||'</id></element></root>';
		PROC_INSERT_LICHSU_TUYENKENH(usercreate_,id_tuyenkenh,6,str);
	end if;
	return i;
END SAVE_TUYENKENHDEXUAT;

/

--------------------------------------------------------
--  DDL for Function GET_USERPHUTRACHKENH
--------------------------------------------------------

  CREATE OR REPLACE FUNCTION "THUEKENH"."GET_USERPHUTRACHKENH" (tuyenkenhId_ in varchar2) RETURN SYS_REFCURSOR AS
-- Lay danh sach user phu trach tuyen kenh
l_cursor SYS_REFCURSOR;
v_phongban_id number;
v_khuvuc_id number;
BEGIN
	select phongban_id,t1.khuvuc_id into v_phongban_id,v_khuvuc_id  from TUYENKENH t0 left join doitac t1 on t0.DOITAC_ID = t1.ID where t0.ID = tuyenkenhId_;
	OPEN l_cursor FOR select * from ACCOUNTS t where IDPHONGBAN = v_phongban_id AND t.id in (select account_id from account_khuvuc where KHUVUC_ID = v_khuvuc_id);
	RETURN l_cursor;
END GET_USERPHUTRACHKENH;

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
      -- send mail/sms
      SEND_SMS(tuyenkenh_id_,3,null);
      SEND_EMAIL(tuyenkenh_id_,3,null);
			select dexuat_id into iDexuat from tuyenkenhdexuat where id=tuyenkenh_dexuat_id and deleted=0;
			if(iDexuat is not null) then
				select count(*) into iTuyenKenhDeXuatChuaBanGiao  from tuyenkenhdexuat where dexuat_id=iDexuat and trangthai!=1 and  deleted=0;
				if(iTuyenKenhDeXuatChuaBanGiao = 0) then
					update dexuat set trangthai=1 where id=iDexuat;
				end if;
			end if;
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
  -- Kiem tra xem de xuat nao da den han ban giao nhung chua ban giao xong
  for rec in (select t.ID,t.TUYENKENH_ID from TUYENKENHDEXUAT t left join TUYENKENH t1 on t.TUYENKENH_ID=t1.ID 
where t.DELETED = 0 and t.NGAYHENBANGIAO < sysdate and t.TRANGTHAI = 0 and t.FLAG_SENDMAIL is null) loop
    SEND_SMS(rec.TUYENKENH_ID,2,null);
    SEND_EMAIL(rec.TUYENKENH_ID,2,null);
    update TUYENKENHDEXUAT set FLAG_SENDMAIL = 1 where ID = rec.ID;
  end loop;
  
  -- Cap nhat trang thai ho so thanh toan
END PROC_SCHEDULE;

/


ALTER TABLE SMS 
ADD (TYPE NUMBER DEFAULT 0 );

--------------------------------------------------------
--  DDL for Procedure SEND_SMS
--------------------------------------------------------
set define off;

  CREATE OR REPLACE PROCEDURE "THUEKENH"."SEND_SMS" (
p_tuyenkenh_id IN VARCHAR2, 
p_type IN NUMBER,
p_content in varchar2
) AS
v_sms_content varchar2(1000);
v_phongban_id number;
l_cursor SYS_REFCURSOR;
vRow ACCOUNTS%rowtype;
BEGIN
  --select phongban_id into v_phongban_id from TUYENKENH where ID = p_tuyenkenh_id;
  if(p_content is null or p_content = '') then
    if(p_type = 1) then -- bat dau ban giao
      v_sms_content := 'Tuyen kenh '||p_tuyenkenh_id|| ' : bat dau ban giao';
    elsif (p_type = 2) then -- toi deadline chua ban giao
      v_sms_content := 'Tuyen kenh '||p_tuyenkenh_id|| ' : da den deadline nhung chua ban giao';
    elsif (p_type = 3) then -- da ban giao xong
      v_sms_content := 'Tuyen kenh '||p_tuyenkenh_id|| ' : da ban giao xong';
    end if;
  else
    v_sms_content := p_content;
  end if;
  l_cursor := GET_USERPHUTRACHKENH(p_tuyenkenh_id);
  loop
      fetch l_cursor into vRow;
      exit when l_cursor%notfound;      
      if(vRow.phone is not null) then
        insert into sms values (sysdate,vRow.phone,v_sms_content,p_type);
        INSERT INTO SMS_QUEUE@SMS6(ID, CALLLED_NUMBER,SMS_CONTENT,REQUEST_DATE_TIME,SMS_TYPE,STATUS,SCHEDULE_DATE_TIME,USER_NAME,PC,SMSC_CODE) 
        VALUES(SMS_QUEUE_SEQ.NEXTVAL@SMS6, vRow.phone, v_sms_content, sysdate, 0, 0, sysdate, 'SYSTEM', '10.18.18.52','NOIMANG');
      end if;
      --dbms_output.put_line(vRow.USERNAME);
  end loop;
  close l_cursor;
  --for rec in (select GET_USERPHUTRACHKENH(p_tuyenkenh_id) from dual) loop
   -- if(rec.phone is not null) then
      --insert into sms values (sysdate,rec.phone,v_sms_content);
     -- dbms_output.put_line(rec.USERNAME);
    --end if;
  --end loop;
END SEND_SMS;

/


--------------------------------------------------------
--  DDL for Procedure SEND_EMAIL
--------------------------------------------------------
set define off;

  CREATE OR REPLACE PROCEDURE "THUEKENH"."SEND_EMAIL" (
p_tuyenkenh_id IN VARCHAR2, 
p_type IN NUMBER,
p_content IN CLOB
)  AS
v_email_content CLOB;
v_phongban_id number;
l_cursor SYS_REFCURSOR;
vRow ACCOUNTS%rowtype;
BEGIN
  --select phongban_id into v_phongban_id from TUYENKENH where ID = p_tuyenkenh_id;
  if(p_content is null or p_content = '') then
    if(p_type = 1) then -- bat dau ban giao
      v_email_content := 'Tuyen kenh '||p_tuyenkenh_id|| ' : bat dau ban giao';
    elsif (p_type = 2) then -- toi deadline chua ban giao
      v_email_content := 'Tuyen kenh '||p_tuyenkenh_id|| ' : da den deadline nhung chua ban giao';
    elsif (p_type = 3) then -- da ban giao xong
      v_email_content := 'Tuyen kenh '||p_tuyenkenh_id|| ' : da ban giao xong';
    end if;
  else
    v_email_content := p_content;
  end if;
  l_cursor := GET_USERPHUTRACHKENH(p_tuyenkenh_id);
  loop
      fetch l_cursor into vRow;
      exit when l_cursor%notfound;      
      -- insert into sms values (sysdate,vRow.phone,v_sms_content);
      --dbms_output.put_line(vRow.USERNAME);
  end loop;
  close l_cursor;
END SEND_EMAIL;

/

