--------------------------------------------------------
--  DDL for Function FN_ISLOCK_CTPL
--------------------------------------------------------

  CREATE OR REPLACE FUNCTION "THUEKENH"."FN_ISLOCK_CTPL" (p_chitietphuluc_id IN NUMBER) RETURN NUMBER AS 
v_num NUMBER := 0;
BEGIN
    select count(*) into v_num from PHULUC where NAM is not null and DELETED = 0 and chitietphuluc_id = p_chitietphuluc_id;
    if(v_num > 0) then
        return 1;
  end if;
    RETURN 0;
END FN_ISLOCK_CTPL;

/

--------------------------------------------------------
--  DDL for Function FIND_PHULUC
--------------------------------------------------------

  CREATE OR REPLACE FUNCTION "THUEKENH"."FIND_PHULUC" (
iDisplayStart IN NUMBER,
iDisplayLength IN NUMBER,
tenhopdong_ in varchar2,
tenphuluc_ in varchar2,
loaiphuluc_ in varchar2,
trangthai_ in varchar2,
ngayky_from in varchar2,
ngayky_end in varchar2,
ngayhieuluc_from in varchar2,
ngayhieuluc_end in varchar2,
hopdong_id_ in varchar2,
ischeckAvailable_ in varchar2,
ngayDSC_ in varchar2
) RETURN SYS_REFCURSOR AS
l_cursor SYS_REFCURSOR;
v_vcsql VARCHAR2(2000);
v_vcsqlwhere VARCHAR2(1000);
i NUMBER;
vDate date;
BEGIN
  v_vcsqlwhere := ' t.DELETED = 0 ';
  if(tenhopdong_ is not null) then
    v_vcsqlwhere := v_vcsqlwhere ||' and t0.ID = '''||tenhopdong_||''' ';
  end if;
  if(tenphuluc_ is not null) then
    v_vcsqlwhere := v_vcsqlwhere ||' and t.TENPHULUC like ''%'||tenphuluc_||'%'' ';
  end if;
  if(loaiphuluc_ is not null) then
    v_vcsqlwhere := v_vcsqlwhere ||' and t.LOAIPHULUC = '||loaiphuluc_||' ';
  end if;
  if(trangthai_ is not null) then
    v_vcsqlwhere := v_vcsqlwhere ||' and t.TRANGTHAI = '||trangthai_||' ';
  end if;
  if(ngayky_from is not null) then
    v_vcsqlwhere := v_vcsqlwhere ||' and t.NGAYKY >= TO_DATE('''||ngayky_from||''',''DD-MM-RRRR'') ';
  end if;
  if(ngayky_end is not null) then
    v_vcsqlwhere := v_vcsqlwhere ||' and t.NGAYKY <= TO_DATE('''||ngayky_end||''',''DD-MM-RRRR'') ';
  end if;
  if(ngayhieuluc_from is not null) then
    v_vcsqlwhere := v_vcsqlwhere ||' and t.NGAYHIEULUC >= TO_DATE('''||ngayhieuluc_from||''',''DD-MM-RRRR'') ';
  end if;
  if(ngayhieuluc_end is not null) then
    v_vcsqlwhere := v_vcsqlwhere ||' and t.NGAYHIEULUC <= TO_DATE('''||ngayhieuluc_end||''',''DD-MM-RRRR'') ';
  end if;
  if(hopdong_id_ is not null) then
    v_vcsqlwhere := v_vcsqlwhere ||' and t.HOPDONG_ID = '||hopdong_id_||' ';
  end if;
  if(ischeckavailable_ is not null) then
    v_vcsqlwhere := v_vcsqlwhere ||' and FN_PHULUC_AVAILABLE(t.ID,'''|| ngaydsc_ ||''')>0';
  end if;
  v_vcsql := 'select rownum as rn,dulieu.* from (SELECT t.*,t0.SOHOPDONG,t0.LOAIHOPDONG,t0.DOITAC_ID,t2.TENDOITAC,FIND_PHULUC_BITHAYTHE(t.ID) as PHULUCBITHAYTHE,case when NAM is null then 0 else 1 end as ISLOCK FROM PHULUC t
    left join HOPDONG t0 on t.HOPDONG_ID = t0.ID
    left join DOITAC t2 on t0.DOITAC_ID = t2.ID  WHERE ' || v_vcsqlwhere || ' order by t.ID desc) dulieu ';
  v_vcsql := 'SELECT * FROM (' || v_vcsql || ') WHERE rn > ' || iDisplayStart || ' and rn <= ' || (iDisplayStart+iDisplayLength);
  --dbms_output.put_line(v_vcsql);
 --test(v_vcsql);
  OPEN l_cursor FOR v_vcsql;
  RETURN l_cursor;
END FIND_PHULUC;

/

--------------------------------------------------------
--  DDL for Procedure PROC_DELETE_PHULUC
--------------------------------------------------------
set define off;

  CREATE OR REPLACE PROCEDURE "THUEKENH"."PROC_DELETE_PHULUC" (
pi_array in TABLE_VARCHAR,
usercreate_ in varchar2,
timeaction_ in number
) AS 
i INTEGER := 1;
BEGIN
	--for i in pi_array.first .. pi_array.last loop
	for rec in (SELECT *  FROM PHULUC  where DELETED = 0 and ID in (select * from table(pi_array))) loop
		update PHULUC set DELETED = timeaction_ where ID = rec.ID;
		PROC_INSERT_LICHSU_PHULUC(usercreate_,rec.ID,3,'');
    update SUCOKENH set PHULUC_ID = null where PHULUC_ID = rec.ID;
	end loop;
END PROC_DELETE_PHULUC;

/

--------------------------------------------------------
--  DDL for Function FN_SAVEDOISOATCUOC
--------------------------------------------------------

  CREATE OR REPLACE FUNCTION "THUEKENH"."FN_SAVEDOISOATCUOC" (
p_doisoatcuoc_id in number,
doitac_id_ in varchar2,
tungay_ in date,
denngay_ in date,
phulucs in TABLE_VARCHAR,
sucos in TABLE_VARCHAR,
timecreate_ in number,
matlienlactu_ in date,
matlienlacden_ in date
)  RETURN SYS_REFCURSOR AS
l_cursor SYS_REFCURSOR;
-- Bien dung cho bang DOISOATCUOC
vDoiSoatCuocId number;
vDSCThanhTien number := 0;
vDSCDaThanhToan number := 0;
vDSCDauNoiHoaMang number := 0;
vDSCConThanhToan number := 0;
vGiamTruMLL number := 0;
-- Bien dung cho bang DOISOATCUOC_PHULUC
vThang number;
vNgay number;
vSoNgay number;
vTuNgay date;
vDenNgay date;
vThanhTien number;
vDauNoiHoaMang number;
vDaThanhToan number;
vConThanhToan number;
vStr varchar2(100);
vStt number := 0;
BEGIN
    if(p_doisoatcuoc_id is not null) then --update
        vDoiSoatCuocId := p_doisoatcuoc_id;
        update DOISOATCUOC set DOITAC_ID = doitac_id_, TUNGAY = tungay_, DENNGAY = denngay_, MATLIENLACTU = matlienlactu_, MATLIENLACDEN = matlienlacden_ where ID = vDoiSoatCuocId;
        delete from DOISOATCUOC_PHULUC where DOISOATCUOC_ID = vDoiSoatCuocId;
        delete from DOISOATCUOC_SUCO where DOISOATCUOC_ID = vDoiSoatCuocId;
    else
        vDoiSoatCuocId := SEQ_DOISOATCUOC.nextval;
        insert into DOISOATCUOC(ID,DOITAC_ID,TUNGAY,DENNGAY,TIMECREATE,DELETED,MATLIENLACTU,MATLIENLACDEN) values (vDoiSoatCuocId,doitac_id_,tungay_,denngay_,timecreate_,timecreate_,matlienlactu_,matlienlacden_);
    end if;

    for rec in (select t.*,case when PHULUCTHAYTHE_ID is not null then PHULUCTHAYTHE_ID else ID end as num from PHULUC t where DELETED = 0 and ID in ((select * from table(phulucs))) order by num desc) loop
    vStt := vStt + 1;
        if(rec.THANG is null) then -- phu luc ke khai thanh toan lan dau
            vTuNgay := rec.NGAYHIEULUC;
            vDauNoiHoaMang := rec.CUOCDAUNOI;
        else
            vTuNgay := tungay_;
            vDauNoiHoaMang := 0;
        end if;

        if(rec.NGAYHETHIEULUC < denngay_) then
            vDenNgay := rec.NGAYHETHIEULUC;
        else
            vDenNgay := denngay_;
        end if;
        vstr := time_between(vTuNgay,vDenNgay);
        vNgay := to_number(substr(vstr,instr(vstr,',') + 1));
        vThang := to_number(substr(vstr,1,instr(vstr,',')-1));
        vSoNgay := vThang * 30 + vNgay;
        vDaThanhToan := 0;
        if(vSoNgay < 0) then -- lay lai so tien da thanh toan cho phu luc nay o thang truoc (do ky tre)
            for recDSC_PL in (select t2.* from thanhtoan t left join doisoatcuoc t1 on t.doisoatcuoc_id = t1.id left join doisoatcuoc_phuluc t2 on t2.doisoatcuoc_id = t1.id where t2.phuluc_id = rec.ID and t.DELETED = 0 and t1.DELETED=0 and t1.denngay >= vDenNgay order by t.TIMECREATE desc) loop
                vSoNgay := vSoNgay + (recDSC_PL.SOTHANG * 30) + recDSC_PL.SONGAY;
                vDaThanhToan := vDaThanhToan + recDSC_PL.CONTHANHTOAN;
                vTuNgay := recDSC_PL.TUNGAY;
            end loop;
        end if;
        vstr := time_between(vTuNgay,vDenNgay);
        vNgay := to_number(substr(vstr,instr(vstr,',') + 1));
        vThang := to_number(substr(vstr,1,instr(vstr,',')-1));
    if(vSoNgay < 0) then -- chon sai phu luc
      insert into DOISOATCUOC_PHULUC(DOISOATCUOC_ID,PHULUC_ID,TUNGAY,DENNGAY,SOTHANG,SONGAY,THANHTIEN,DAUNOIHOAMANG,DATHANHTOAN,CONTHANHTOAN,STT) values (vDoiSoatCuocId,rec.ID,null,null,0,0,0,0,0,0,vStt);
    else
      vThanhTien := floor(rec.GIATRITRUOCTHUE / 30 * vSoNgay);
      vConThanhToan := vThanhTien + vDauNoiHoaMang - vDaThanhToan;
      insert into DOISOATCUOC_PHULUC(DOISOATCUOC_ID,PHULUC_ID,TUNGAY,DENNGAY,SOTHANG,SONGAY,THANHTIEN,DAUNOIHOAMANG,DATHANHTOAN,CONTHANHTOAN,STT) values (vDoiSoatCuocId,rec.ID,vTuNgay,vDenNgay,vThang,vNgay,vThanhTien,vDauNoiHoaMang,vDaThanhToan,vConThanhToan,vStt);

      vDSCThanhTien:= vDSCThanhTien + vThanhTien;
      vDSCDauNoiHoaMang:= vDSCDauNoiHoaMang + vDauNoiHoaMang;
      vDSCDaThanhToan:= vDSCDaThanhToan + vDaThanhToan;
      vDSCConThanhToan:= vDSCConThanhToan + vConThanhToan;
    end if;
    end loop;

    --Tinh gia tri giam tru mat lien lac
    for rec in (select * from SUCOKENH where DELETED = 0 and ID in ((select * from table(sucos)))) loop
    insert into DOISOATCUOC_SUCO(DOISOATCUOC_ID,SUCO_ID) values (vDoiSoatCuocId,rec.ID);
        vGiamTruMLL := vGiamTruMLL + rec.GIAMTRUMLL;
    end loop;
    vDSCConThanhToan := vDSCConThanhToan - vGiamTruMLL;
    -- Cap nhat lai bang doi soat cuoc
    update DOISOATCUOC SET GIAMTRUMLL = vGiamTruMLL, THANHTIEN = vDSCThanhTien, TONGDAUNOIHOAMANG = vDSCDauNoiHoaMang, TONGDATHANHTOAN = vDSCDaThanhToan, TONGCONTHANHTOAN = vDSCConThanhToan where ID = vDoiSoatCuocId;
  open l_cursor for select vDoiSoatCuocId as ID,vDSCThanhTien as THANHTIEN,vGiamTruMLL as GIAMTRUMLL, vDSCDauNoiHoaMang as TONGDAUNOIHOAMANG, vDSCDaThanhToan as TONGDATHANHTOAN, vDSCConThanhToan as TONGCONTHANHTOAN from dual;
  return l_cursor;
END FN_SAVEDOISOATCUOC;

/

--------------------------------------------------------
--  DDL for Procedure PROC_SCHEDULE
--------------------------------------------------------
set define off;

  CREATE OR REPLACE PROCEDURE "THUEKENH"."PROC_SCHEDULE" AS
v_sms_content varchar2(5000);
v_phone varchar2(20);
v_tuyenkenh_ids varchar2(2000) := '';
pi_array TABLE_VARCHAR := TABLE_VARCHAR();
i number := 1;
dFrom date;
dEnd date;
nMonth number;
nYear number;
str varchar2(2000);
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
  for rec in (select t0.ID,t0.DOISOATCUOC_ID,t0.SOHOSO,t1.* from THANHTOAN t0 left join v_hoso_thanhtoan t1 on t0.SOHOSO = t1.mahoso where t0.deleted = 0 and t0.trangthai != 1) loop
    update THANHTOAN set trangthai = 1 where ID = rec.ID;
    --insert into THANHTOAN_INFO(THANHTOAN_ID,DELETED,MSNHANVIEN,HOTENNHANVIEN,MSHOSO,MAHOSO,MSNHANVIENNOPHS,SOTIEN,NGAYNOP,MAPHONGBAN,SOTIENTHUC,NGAYTRAHS,NGAYNHANLAI,SOCHUNGTU,KTV,KTT,BGD,SOCT,NGAYCT) VALUES (rec.ID,0, rec.MSNHANVIEN, rec.HOTENNHANVIEN, rec.MSHOSO, rec.MAHOSO, rec.MSNHANVIENNOPHS, rec.SOTIEN, rec.NGAYNOP, rec.MAPHONGBAN, rec.SOTIENTHUC, rec.NGAYTRAHS, rec.NGAYNHANLAI, rec.SOCHUNGTU, rec.KTV, rec.KTT, rec.BGD, rec.SOCT, rec.NGAYCT);

    insert into THANHTOAN_INFO(THANHTOAN_ID,DELETED,MSNHANVIEN,HOTENNHANVIEN,MSHOSO,MAHOSO,MSNHANVIENNOPHS,SOTIEN,NGAYNOP,MAPHONGBAN,SOTIENTHUC,NGAYTRAHS,NGAYNHANLAI,SOCHUNGTU,KTV,KTT,BGD,SOCT,NGAYCT,SOUNC,SOPHIEUCHI,NGAYXULY) VALUES (rec.ID,0, rec.MSNHANVIEN, rec.HOTENNHANVIEN, rec.MSHOSO, rec.MAHOSO, rec.MSNHANVIENNOPHS, rec.SOTIEN, rec.NGAYNOP, rec.MAPHONGBAN, rec.SOTIENTHUC, rec.NGAYTRAHS, rec.NGAYNHANLAI, rec.SOCHUNGTU, rec.KTV, rec.KTT, rec.BGD, rec.SOCT, rec.NGAYCT,rec.SOUNC,rec.SOPHIEUCHI,rec.NGAYXULY);
	update SUCOKENH SET TRANGTHAI = 1 WHERE THANHTOAN_ID = rec.ID;
	
	select TUNGAY,DENNGAY into dFrom,dEnd from DOISOATCUOC where id =  rec.DOISOATCUOC_ID;
    for rec2 in (select t.* from PHULUC t left join DOISOATCUOC_PHULUC t1 on t.ID = t1.PHULUC_ID where t.TRANGTHAI != 1 AND DOISOATCUOC_ID = rec.DOISOATCUOC_ID) loop
		nMonth := extract(month from dFrom);
		nYear := extract(year from dFrom);
		if(rec2.NGAYHETHIEULUC is not null AND rec2.NGAYHETHIEULUC <= dEnd) then --phu luc het hieu luc
			nMonth := extract(month from rec2.NGAYHETHIEULUC);
			nYear := extract(year from rec2.NGAYHETHIEULUC);
			update PHULUC set TRANGTHAI = 1 where ID = rec2.ID;
		end if;
		update PHULUC set THANG = nMonth,NAM = nYear where ID = rec2.ID;
		str := '<root><element><sohoso_id>'||rec.ID||'</sohoso_id><sohoso>'||rec.SOHOSO||'</sohoso><thang>'||nMonth||'</thang><nam>'||nYear||'</nam></element></root>';
		PROC_INSERT_LICHSU_PHULUC('SYSTEM',rec2.ID,6,str);
		str := '<root><element><sohoso_id>'||rec.ID||'</sohoso_id><sohoso>'||rec.SOHOSO||'</sohoso></element></root>';
		for rec3 in (select * from CHITIETPHULUC_TUYENKENH where PHULUC_ID = rec2.ID) loop
			PROC_INSERT_LICHSU_TUYENKENH('SYSTEM',rec3.TUYENKENH_ID,5,str);
		end loop;
    end loop;

  end loop;
  INSERT INTO SMS_QUEUE@SMS6(ID, CALLLED_NUMBER,SMS_CONTENT,REQUEST_DATE_TIME,SMS_TYPE,STATUS,SCHEDULE_DATE_TIME,USER_NAME,PC,SMSC_CODE)
    VALUES(SMS_QUEUE_SEQ.NEXTVAL@SMS6, '932337487', 'Finish schedule jobs', sysdate, 0, 0, sysdate, 'SYSTEM', '10.18.18.52','NOIMANG');
END PROC_SCHEDULE;

/

--------------------------------------------------------
--  DDL for Function FIND_CHITIETPHULUCBYID
--------------------------------------------------------

  CREATE OR REPLACE FUNCTION "THUEKENH"."FIND_CHITIETPHULUCBYID" (
iDisplayStart IN NUMBER,
iDisplayLength IN NUMBER,
chitietphulucid_ in varchar2
) RETURN SYS_REFCURSOR AS
l_cursor SYS_REFCURSOR;
v_vcsql VARCHAR2(2000);
v_vcsqlwhere VARCHAR2(1000);
i NUMBER;
BEGIN
  v_vcsqlwhere := 'c.CHITIETPHULUC_ID = '|| chitietphulucid_ ||' ';
  v_vcsql := 'select rownum as rn,dulieu.* from (SELECT c.*,t.ID,t.MADIEMDAU,t.MADIEMCUOI,lgt.LOAIGIAOTIEP,t.DUNGLUONG,c.SOLUONG as SLTUYENKENH
                                                 FROM CHITIETPHULUC_TUYENKENH c
                                                 INNER JOIN TUYENKENH t ON c.TUYENKENH_ID=t.ID
                                                 INNER JOIN LOAIGIAOTIEP lgt ON t.GIAOTIEP_ID=lgt.ID
                                                 WHERE ' || v_vcsqlwhere || ' order by t.ID desc) dulieu ';
  v_vcsql := 'SELECT * FROM (' || v_vcsql || ') WHERE rn > ' || iDisplayStart || ' and rn <= ' || (iDisplayStart+iDisplayLength);
  --dbms_output.put_line(v_vcsql);
 --test(v_vcsql);
  OPEN l_cursor FOR v_vcsql;
  RETURN l_cursor;
END FIND_CHITIETPHULUCBYID;

/

