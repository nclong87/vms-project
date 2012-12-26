--------------------------------------------------------
--  DDL for Function FIND_CHITIETPHULUC
--------------------------------------------------------

  CREATE OR REPLACE FUNCTION "THUEKENH"."FIND_CHITIETPHULUC" (
iDisplayStart IN NUMBER,   
iDisplayLength IN NUMBER, 
tenchitietphuluc_ in varchar2
) RETURN SYS_REFCURSOR AS
l_cursor SYS_REFCURSOR;
v_vcsql VARCHAR2(2000);
v_vcsqlwhere VARCHAR2(1000);
i NUMBER;
BEGIN
	v_vcsqlwhere := ' t.DELETED = 0 ';
	if(tenchitietphuluc_ is not null) then
		v_vcsqlwhere := v_vcsqlwhere ||' and t.TENCHITIETPHULUC like ''%'||tenchitietphuluc_||'%'' ';
	end if;
	v_vcsql := 'select rownum as rn,dulieu.*,FN_ISLOCK_CTPL(dulieu.ID) as ISBLOCK from (SELECT t.* FROM CHITIETPHULUC t WHERE ' || v_vcsqlwhere || ' order by t.ID desc) dulieu ';
	v_vcsql := 'SELECT * FROM (' || v_vcsql || ') WHERE rn > ' || iDisplayStart || ' and rn <= ' || (iDisplayStart+iDisplayLength);
	--dbms_output.put_line(v_vcsql);
 --test(v_vcsql);
	OPEN l_cursor FOR v_vcsql;
	RETURN l_cursor;
END FIND_CHITIETPHULUC;

/

--------------------------------------------------------
--  DDL for Function FN_ISLOCK_CTPL
--------------------------------------------------------

  CREATE OR REPLACE FUNCTION "THUEKENH"."FN_ISLOCK_CTPL" (p_chitietphuluc_id IN NUMBER) RETURN NUMBER AS 
v_num NUMBER := 0;
BEGIN
	select count(*) into v_num from PHULUC where DELETED = 0 and chitietphuluc_id = p_chitietphuluc_id;
	if(v_num > 0) then
		return 1;
  end if;
	RETURN 0;
END FN_ISLOCK_CTPL;

/

--------------------------------------------------------
--  DDL for Function FN_GETPHULUC
--------------------------------------------------------

  CREATE OR REPLACE FUNCTION "THUEKENH"."FN_GETPHULUC" 
(
  p_tuyenkenh_id IN varchar2
) RETURN VARCHAR2 AS 
v_phuluc_id number := 0;
BEGIN
    begin
    select t.ID into v_phuluc_id from phuluc t left join chitietphuluc_tuyenkenh t1 on t.CHITIETPHULUC_ID = t1.CHITIETPHULUC_ID
where t.deleted = 0 and t1.tuyenkenh_id = p_tuyenkenh_id and ( (t.ngayhethieuluc is null and t.ngayhieuluc  < sysdate + 1 ) or (t.ngayhethieuluc is not null and t.ngayhethieuluc >= sysdate and t.ngayhieuluc < sysdate + 1 ) );
    EXCEPTION WHEN OTHERS THEN
      v_phuluc_id:=0;
    END;
    RETURN v_phuluc_id;
END FN_GETPHULUC;

/

--------------------------------------------------------
--  DDL for Function FIND_TUYENKENHBANGIAO
--------------------------------------------------------

  CREATE OR REPLACE FUNCTION "THUEKENH"."FIND_TUYENKENHBANGIAO" (
iDisplayStart IN NUMBER,
iDisplayLength IN NUMBER,
makenh_ in varchar2,
loaigiaotiep_ in varchar2,
madiemdau_ in varchar2,
madiemcuoi_ in varchar2,
duan_ in varchar2,
ngaydenghibangiao_ in varchar2,
ngayhenbangiao_ in varchar2,
dexuat_id_ in varchar2,
account_id in varchar2,
phongban_id in varchar2,
isAllow in varchar2,
iTrangThai in nvarchar2
) RETURN SYS_REFCURSOR AS
l_cursor SYS_REFCURSOR;
v_vcsql VARCHAR2(2000);
v_vcsqlwhere VARCHAR2(1000);
i NUMBER;
BEGIN
  v_vcsqlwhere := ' t.DELETED = 0 ';--and t0.khuvuc_id='''||khuvuc_id||'''';
  if(isAllow = '0' ) then
    v_vcsqlwhere := v_vcsqlwhere || 'and t4.khuvuc_id in (select KHUVUC_ID from ACCOUNT_KHUVUC where ACCOUNT_ID ='||account_id||') and t0.PHONGBAN_ID ='''||phongban_id||'''';
  end if;

  if(dexuat_id_ is not null) then
    v_vcsqlwhere := v_vcsqlwhere ||' and t.DEXUAT_ID = '||dexuat_id_||' ';
  end if;
  if(makenh_ is not null) then
    v_vcsqlwhere := v_vcsqlwhere ||' and t0.ID like '''||replace(makenh_, '*', '%')||'%'' ';
  end if;
  if(loaigiaotiep_ is not null) then
    v_vcsqlwhere := v_vcsqlwhere ||' and GIAOTIEP_ID = '||loaigiaotiep_||' ';
  end if;
  if(duan_ is not null) then
    v_vcsqlwhere := v_vcsqlwhere ||' and t0.DUAN_ID = '||duan_||' ';
  end if;
  if(madiemdau_ is not null) then
    v_vcsqlwhere := v_vcsqlwhere ||' and t0.MADIEMDAU like '''||replace(madiemdau_, '*', '%')||''' ';
  end if;
  if(madiemcuoi_ is not null) then
    v_vcsqlwhere := v_vcsqlwhere ||' and t0.MADIEMCUOI like '''||replace(madiemcuoi_, '*', '%')||''' ';
  end if;
  if(ngaydenghibangiao_ is not null) then
    v_vcsqlwhere := v_vcsqlwhere ||' and t.NGAYDENGHIBANGIAO = TO_DATE('''||ngaydenghibangiao_||''',''DD-MM-RRRR'') ';
  end if;
  if(ngayhenbangiao_ is not null) then
    v_vcsqlwhere := v_vcsqlwhere ||' and t.NGAYHENBANGIAO = TO_DATE('''||ngayhenbangiao_||''',''DD-MM-RRRR'') ';
  end if;
  v_vcsql := 'select rownum as rn,dulieu.* from (SELECT t.ID as ID,t0.ID as TUYENKENH_ID,MADIEMDAU,MADIEMCUOI,t1.LOAIGIAOTIEP,t0.giaotiep_id,t0.DUAN_ID,t0.DUNGLUONG,t.SOLUONG, dx.tenvanban as tenvanbandexuat,t2.tenduan,tiendo,dx.id as MAVANBANDEXUAT,TENPHONGBAN,tendoitac FROM TUYENKENHDEXUAT t left join TUYENKENH t0 on t.TUYENKENH_ID = t0.ID left join LOAIGIAOTIEP t1 on t0.GIAOTIEP_ID = t1.ID left join DUAN t2 on t0.DUAN_ID = t2.ID left join PHONGBAN t3 on t0.PHONGBAN_ID = t3.ID left join Doitac t4 on t0.DoiTac_id = t4.ID left join dexuat dx on dx.id=t.dexuat_id where  t.trangthai='||iTrangThai||' and '|| v_vcsqlwhere || ' order by t0.ID desc) dulieu ';
  v_vcsql := 'SELECT * FROM (' || v_vcsql || ') WHERE rn >= ' || iDisplayStart || ' and rn <= ' || (iDisplayStart+iDisplayLength);
  --dbms_output.put_line(v_vcsql);
 --test(v_vcsql);
  OPEN l_cursor FOR v_vcsql;
  RETURN l_cursor;
END FIND_TUYENKENHBANGIAO;

/

--------------------------------------------------------
--  DDL for Function FN_SAVEDOISOATCUOC
--------------------------------------------------------

  CREATE OR REPLACE FUNCTION "THUEKENH"."FN_SAVEDOISOATCUOC" (
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
vSoNgay number;
vTuNgay date;
vDenNgay date;
vThanhTien number;
vDauNoiHoaMang number;
vDaThanhToan number;
vConThanhToan number;
BEGIN
  vDoiSoatCuocId := SEQ_DOISOATCUOC.nextval;
	insert into DOISOATCUOC(ID,DOITAC_ID,TUNGAY,DENNGAY,TIMECREATE,DELETED,MATLIENLACTU,MATLIENLACDEN) values (vDoiSoatCuocId,doitac_id_,tungay_,denngay_,timecreate_,timecreate_,matlienlactu_,matlienlacden_);
	for rec in (select * from PHULUC where DELETED = 0 and ID in ((select * from table(phulucs)))) loop
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
		vSoNgay := vDenNgay - vTuNgay + 1;
		vDaThanhToan := 0;
		if(vSoNgay < 0) then -- lay lai so tien da thanh toan cho phu luc nay o thang truoc (do ky tre)
			for recDSC_PL in (select t2.* from thanhtoan t left join doisoatcuoc t1 on t.doisoatcuoc_id = t1.id left join doisoatcuoc_phuluc t2 on t2.doisoatcuoc_id = t1.id where t2.phuluc_id = rec.ID and t1.tungay <= vDenNgay and t1.denngay >= vDenNgay order by t.TIMECREATE desc) loop
				vSoNgay := vSoNgay + (recDSC_PL.SOTHANG * 30) + recDSC_PL.SONGAY;
				vDaThanhToan := vDaThanhToan + recDSC_PL.CONTHANHTOAN;
				vTuNgay := recDSC_PL.TUNGAY;
			end loop;
		end if;
		vThanhTien := floor(rec.GIATRITRUOCTHUE / 30 * vSoNgay);
		vConThanhToan := vThanhTien + vDauNoiHoaMang - vDaThanhToan;
		insert into DOISOATCUOC_PHULUC(DOISOATCUOC_ID,PHULUC_ID,TUNGAY,DENNGAY,SOTHANG,SONGAY,THANHTIEN,DAUNOIHOAMANG,DATHANHTOAN,CONTHANHTOAN) values (vDoiSoatCuocId,rec.ID,vTuNgay,vDenNgay,floor(vSoNgay/30),MOD(vSoNgay,30),vThanhTien,vDauNoiHoaMang,vDaThanhToan,vConThanhToan);
		
		vDSCThanhTien:= vDSCThanhTien + vThanhTien;
		vDSCDauNoiHoaMang:= vDSCDauNoiHoaMang + vDauNoiHoaMang;
		vDSCDaThanhToan:= vDSCDaThanhToan + vDaThanhToan;
		vDSCConThanhToan:= vDSCConThanhToan + vConThanhToan;
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
--  DDL for Function SAVE_PHULUC
--------------------------------------------------------

  CREATE OR REPLACE FUNCTION "THUEKENH"."SAVE_PHULUC" (
id_ in VARCHAR2,
chitietphuluc_id_ in VARCHAR2,
hopdong_id_ in VARCHAR2,
tenphuluc_ in VARCHAR2,
loaiphuluc_ in VARCHAR2,
ngayky_ in VARCHAR2,
ngayhieuluc_ in VARCHAR2,
usercreate_ in VARCHAR2,
timecreate_ in VARCHAR2,
filename_ in VARCHAR2,
filepath_ in VARCHAR2,
filesize_ in VARCHAR2,
cuocdaunoi_ in VARCHAR2,
giatritruocthue_ in VARCHAR2,
giatrisauthue_ in VARCHAR2,
soluongkenh_ in VARCHAR2,
thang_ in VARCHAR2,
nam_ in VARCHAR2
) RETURN NUMBER AS
i INTEGER := 0;
ngayhethan_ DATE := null;
str varchar2(500) := '';
v_thang number;
v_nam number;
BEGIN
	--select NGAYHETHAN into ngayhethan_ from HOPDONG where ID = hopdong_id_;
  if(thang_ = 'null') then
    v_thang := null;
  else
    v_thang := to_number(thang_);
  end if;
   if(nam_ = 'null') then
    v_nam := null;
  else
    v_nam := to_number(nam_);
  end if;
	if(id_ is not null) then --update
		update PHULUC set CHITIETPHULUC_ID = chitietphuluc_id_,HOPDONG_ID = hopdong_id_,TENPHULUC = tenphuluc_,LOAIPHULUC = loaiphuluc_,NGAYKY = ngayky_,NGAYHIEULUC = ngayhieuluc_,FILENAME = filename_,FILEPATH = filepath_,FILESIZE = filesize_,CUOCDAUNOI = cuocdaunoi_,GIATRITRUOCTHUE = giatritruocthue_, GIATRISAUTHUE = giatrisauthue_, SOLUONGKENH = soluongkenh_, THANG = v_thang, NAM = v_nam where ID = id_;
		i := id_;
		update TUYENKENHDEXUAT set FLAG = 0 where TUYENKENH_ID in (SELECT TUYENKENH_ID FROM CHITIETPHULUC_TUYENKENH where PHULUC_ID = i); -- reset lai nhung TUYENKENHDEXUAT truoc
		update PHULUC set PHULUCTHAYTHE_ID = null,NGAYHETHIEULUC = null where PHULUCTHAYTHE_ID = i;
		update CHITIETPHULUC_TUYENKENH set PHULUC_ID = null where PHULUC_ID = i;
		PROC_INSERT_LICHSU_PHULUC(usercreate_,i,2,'');
	else --insert
		i:=SEQ_PHULUC.nextval;	
		insert into PHULUC(ID,CHITIETPHULUC_ID,HOPDONG_ID,TENPHULUC,LOAIPHULUC,NGAYKY,NGAYHIEULUC,THANG,NAM,TRANGTHAI,USERCREATE,TIMECREATE,DELETED,NGAYHETHIEULUC,FILENAME,FILEPATH,FILESIZE,PHULUCTHAYTHE_ID,CUOCDAUNOI,GIATRITRUOCTHUE,GIATRISAUTHUE,SOLUONGKENH) values (i,chitietphuluc_id_,hopdong_id_,tenphuluc_,loaiphuluc_,ngayky_,ngayhieuluc_,v_thang,v_nam,0,usercreate_,timecreate_,0,null,filename_,filepath_,filesize_,null,cuocdaunoi_,giatritruocthue_,giatrisauthue_,soluongkenh_);
		PROC_INSERT_LICHSU_PHULUC(usercreate_,i,1,'');
	end if;
	update TUYENKENHDEXUAT set FLAG = i where TUYENKENH_ID in (SELECT TUYENKENH_ID FROM CHITIETPHULUC_TUYENKENH where CHITIETPHULUC_ID = chitietphuluc_id_);
	update CHITIETPHULUC_TUYENKENH set PHULUC_ID = i where CHITIETPHULUC_ID = chitietphuluc_id_;
	str := '<root><element><phuluc_id>'||i||'</phuluc_id><tenphuluc>'||tenphuluc_||'</tenphuluc></element></root>';
	for rec in (select * from CHITIETPHULUC_TUYENKENH where CHITIETPHULUC_ID = chitietphuluc_id_) loop
		PROC_INSERT_LICHSU_TUYENKENH(usercreate_,rec.TUYENKENH_ID,4,str);
	end loop;
	return i;
END SAVE_PHULUC;

/

