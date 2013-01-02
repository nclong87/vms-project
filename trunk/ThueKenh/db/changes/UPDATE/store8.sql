--------------------------------------------------------
--  DDL for Function FN_ISLOCK_DOISOATCUOC
--------------------------------------------------------

  CREATE OR REPLACE FUNCTION "THUEKENH"."FN_ISLOCK_DOISOATCUOC" (p_doisoatcuoc_id IN NUMBER) RETURN NUMBER AS 
v_num NUMBER := 0;
BEGIN
	select count(*) into v_num from THANHTOAN where DELETED = 0 and DOISOATCUOC_ID = p_doisoatcuoc_id;
	if(v_num > 0) then
		return 1;
  end if;
	RETURN 0;
END FN_ISLOCK_DOISOATCUOC;

/

--------------------------------------------------------
--  DDL for Function FIND_DOISOATCUOC
--------------------------------------------------------

  CREATE OR REPLACE FUNCTION "THUEKENH"."FIND_DOISOATCUOC" (
iDisplayStart IN NUMBER,   
iDisplayLength IN NUMBER, 
id_ in varchar2,
tenbangdoisoatcuoc_ in varchar2
) RETURN SYS_REFCURSOR AS
l_cursor SYS_REFCURSOR;
v_vcsql VARCHAR2(2000);
v_vcsqlwhere VARCHAR2(1000);
i NUMBER;
BEGIN
	v_vcsqlwhere := ' t.DELETED = 0 ';
  if(id_ is not null) then
		v_vcsqlwhere := v_vcsqlwhere ||' and t.ID = '||id_||' ';
  end if;
	if(tenbangdoisoatcuoc_ is not null) then
		v_vcsqlwhere := v_vcsqlwhere ||' and t.TENDOISOATCUOC like ''%'||tenbangdoisoatcuoc_||'%'' ';
	end if;
	v_vcsql := 'select rownum as rn,dulieu.*,FN_ISLOCK_DOISOATCUOC(dulieu.ID) as ISBLOCK from (SELECT t.* FROM DOISOATCUOC t WHERE ' || v_vcsqlwhere || ' order by t.ID desc) dulieu ';
	v_vcsql := 'SELECT * FROM (' || v_vcsql || ') WHERE rn > ' || iDisplayStart || ' and rn <= ' || (iDisplayStart+iDisplayLength);
	--dbms_output.put_line(v_vcsql);
 --test(v_vcsql);
	OPEN l_cursor FOR v_vcsql;
	RETURN l_cursor;
END FIND_DOISOATCUOC;

/

update MENU SET NAMEMENU = 'Quản lý đối soát cước',action = '/bangdoisoatcuoc/bangdoisoatcuoc.action' where ID = 19;commit;

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
vSoNgay number;
vTuNgay date;
vDenNgay date;
vThanhTien number;
vDauNoiHoaMang number;
vDaThanhToan number;
vConThanhToan number;
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
--  DDL for Function FN_EXPORT_DEXUAT
--------------------------------------------------------

  CREATE OR REPLACE FUNCTION "THUEKENH"."FN_EXPORT_DEXUAT" (
select_ in varchar2
) RETURN SYS_REFCURSOR AS
l_cursor SYS_REFCURSOR;
v_vcsql VARCHAR2(2000);
BEGIN
  v_vcsql := 'select '||select_||' from (select rownum as rn,t.ID,TENDOITAC,TENVANBAN,NGAYGUI,NGAYDENGHIBANGIAO,THONGTINTHEM,t.TRANGTHAI from DEXUAT t left join DOITAC t0 on t.DOITAC_ID = t0.ID where t.DELETED = 0) dulieu';
  OPEN l_cursor FOR v_vcsql;
  RETURN l_cursor;
END FN_EXPORT_DEXUAT; 

/

