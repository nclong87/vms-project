CREATE SEQUENCE SEQ_TUYENKENH_IMPORT INCREMENT BY 1 START WITH 1 MAXVALUE 99999 MINVALUE 1;

ALTER TABLE TUYENKENH_IMPORT 
ADD (DUPLICATE NUMBER DEFAULT 0 );

ALTER TABLE DEXUAT  
MODIFY (FILESIZE VARCHAR(20) );

ALTER TABLE VMSGROUP 
ADD (MAINMENU NUMBER DEFAULT 0 );

ALTER TABLE ACCOUNTS 
ADD (MAINMENU NUMBER DEFAULT 0 );

REM INSERTING into THUEKENH.MENU
Insert into THUEKENH.MENU (ID,NAMEMENU,ACTION,ACTIVE,IDROOTMENU) values (24,'Loại giao tiếp','/danhmuc/loaigiaotiep.action',1,8);
Insert into THUEKENH.MENU (ID,NAMEMENU,ACTION,ACTIVE,IDROOTMENU) values (10,'Quản lý tuyến kênh','/tuyenkenh/index.action',1,1);
Insert into THUEKENH.MENU (ID,NAMEMENU,ACTION,ACTIVE,IDROOTMENU) values (11,'Import tuyến kênh','/import/tuyenkenh.action',1,1);
Insert into THUEKENH.MENU (ID,NAMEMENU,ACTION,ACTIVE,IDROOTMENU) values (12,'Quản lý tiến độ bàn giao kênh','/bangiao/index.action',1,1);
Insert into THUEKENH.MENU (ID,NAMEMENU,ACTION,ACTIVE,IDROOTMENU) values (13,'Quản lý văn bản đề xuất','/dexuat/index.action',1,3);
Insert into THUEKENH.MENU (ID,NAMEMENU,ACTION,ACTIVE,IDROOTMENU) values (14,'Quản lý biên bản bàn giao kênh','/bienbanbangiao/index.action',1,3);
Insert into THUEKENH.MENU (ID,NAMEMENU,ACTION,ACTIVE,IDROOTMENU) values (15,'Quản lý biên bản vận hành kênh','/bienbanvanhanh/index.action',1,3);
Insert into THUEKENH.MENU (ID,NAMEMENU,ACTION,ACTIVE,IDROOTMENU) values (16,'Quản lý hợp đồng','/hopdong/index.action',1,4);
Insert into THUEKENH.MENU (ID,NAMEMENU,ACTION,ACTIVE,IDROOTMENU) values (17,'Quản lý phụ lục hợp đồng','/phuluc/index.action',1,4);
Insert into THUEKENH.MENU (ID,NAMEMENU,ACTION,ACTIVE,IDROOTMENU) values (18,'Báo cáo tiến độ','/baocao/tiendo.action',1,6);
Insert into THUEKENH.MENU (ID,NAMEMENU,ACTION,ACTIVE,IDROOTMENU) values (19,'Xuất bảng đối soát cước','/baocao/doisoatcuoc.action',1,6);
Insert into THUEKENH.MENU (ID,NAMEMENU,ACTION,ACTIVE,IDROOTMENU) values (20,'Báo cáo giảm trừ mất liên lạc','/baocao/giamtrumll.action',1,6);
Insert into THUEKENH.MENU (ID,NAMEMENU,ACTION,ACTIVE,IDROOTMENU) values (21,'Báo cáo sự cố theo thời gian','/baocao/suco.action',1,6);
Insert into THUEKENH.MENU (ID,NAMEMENU,ACTION,ACTIVE,IDROOTMENU) values (22,'SỰ CỐ KÊNH','/sucokenh/index.action',1,2);
Insert into THUEKENH.MENU (ID,NAMEMENU,ACTION,ACTIVE,IDROOTMENU) values (23,'QUẢN LÝ HỒ SƠ TT','/thanhtoan/index.action',1,5);
Insert into THUEKENH.MENU (ID,NAMEMENU,ACTION,ACTIVE,IDROOTMENU) values (25,'Đề xuất tuyến kênh','/tuyenkenhdexuat/index.action',1,1);
Insert into THUEKENH.MENU (ID,NAMEMENU,ACTION,ACTIVE,IDROOTMENU) values (4,'Phòng ban','/danhmuc/phongban.action',1,8);
Insert into THUEKENH.MENU (ID,NAMEMENU,ACTION,ACTIVE,IDROOTMENU) values (2,'Quản trị nhóm','/group/index.action',1,7);
Insert into THUEKENH.MENU (ID,NAMEMENU,ACTION,ACTIVE,IDROOTMENU) values (3,'Quản trị quyền','/menu/index.action',0,7);
Insert into THUEKENH.MENU (ID,NAMEMENU,ACTION,ACTIVE,IDROOTMENU) values (1,'Quản trị user','/user/index.action',1,7);
Insert into THUEKENH.MENU (ID,NAMEMENU,ACTION,ACTIVE,IDROOTMENU) values (5,'Đối tác','/danhmuc/doitac.action',1,8);
Insert into THUEKENH.MENU (ID,NAMEMENU,ACTION,ACTIVE,IDROOTMENU) values (6,'Dự án','/danhmuc/duan.action',1,8);
Insert into THUEKENH.MENU (ID,NAMEMENU,ACTION,ACTIVE,IDROOTMENU) values (7,'Cách tính cước','/danhmuc/congthuc.action',1,8);
Insert into THUEKENH.MENU (ID,NAMEMENU,ACTION,ACTIVE,IDROOTMENU) values (8,'Tiêu chuẩn bàn giao kênh','/danhmuc/tieuchuan.action',1,8);
Insert into THUEKENH.MENU (ID,NAMEMENU,ACTION,ACTIVE,IDROOTMENU) values (9,'Khu vực','/danhmuc/khuvuc.action',1,8);

--------------------------------------------------------
--  DDL for Procedure PROC_IMPORT_TUYENKENH
--------------------------------------------------------
set define off;

  CREATE OR REPLACE PROCEDURE "THUEKENH"."PROC_IMPORT_TUYENKENH" (
pi_array in TABLE_NUMBER,
usercreate_ in varchar2,
timecreate_ in date
) AS 
i INTEGER := 1;
BEGIN
	for rec in (SELECT t.ID,t.MADIEMDAU, t.MADIEMCUOI, t0.ID as GIAOTIEP_ID, t1.ID as DUAN_ID, t2.ID as PHONGBAN_ID, t3.ID as KHUVUC_ID, t.DUNGLUONG, t.SOLUONG,DUPLICATE FROM TUYENKENH_IMPORT t left join LOAIGIAOTIEP t0 on t.GIAOTIEP_MA = t0.MA left join DUAN t1 on t.DUAN_MA = t1.MA left join PHONGBAN t2 on t.PHONGBAN_MA = t2.MA left join KHUVUC t3 on t.KHUVUC_MA=t3.MA where t.ID in (select * from table(pi_array))) loop
		if(rec.DUPLICATE != 0) then --duplicate => update tuyenkenh
			update TUYENKENH set MADIEMDAU = rec.MADIEMDAU, MADIEMCUOI = rec.MADIEMCUOI, GIAOTIEP_ID = rec.GIAOTIEP_ID, DUAN_ID = rec.DUAN_ID, PHONGBAN_ID = rec.PHONGBAN_ID, KHUVUC_ID = rec.KHUVUC_ID, DUNGLUONG = rec.DUNGLUONG, SOLUONG = rec.SOLUONG where ID = rec.DUPLICATE;
		else --insert
			i := SEQ_TUYENKENH.nextval;
			insert into TUYENKENH(ID,MADIEMDAU,MADIEMCUOI,GIAOTIEP_ID,DUAN_ID,PHONGBAN_ID,KHUVUC_ID,DUNGLUONG,TRANGTHAI,USERCREATE,TIMECREATE,DELETED,SOLUONG,TRANGTHAI_BAK) values (i,rec.MADIEMDAU,rec.MADIEMCUOI,rec.GIAOTIEP_ID,rec.DUAN_ID,rec.PHONGBAN_ID,rec.KHUVUC_ID,rec.DUNGLUONG,0,usercreate_,timecreate_,0,rec.SOLUONG,0);
		end if;
    delete from TUYENKENH_IMPORT where ID = rec.ID;
	end loop;
END PROC_IMPORT_TUYENKENH;

/

--------------------------------------------------------
--  DDL for Procedure SAVE_TUYENKENH_IMPORT
--------------------------------------------------------
set define off;

  CREATE OR REPLACE PROCEDURE "THUEKENH"."SAVE_TUYENKENH_IMPORT" (
stt_ in NUMBER,
madiemdau_ in VARCHAR2,
madiemcuoi_ in VARCHAR2,
giaotiep_ma_ in VARCHAR2,
duan_ma_ in VARCHAR2,
phongban_ma_ in VARCHAR2,
khuvuc_ma_ in VARCHAR2,
dungluong_ in VARCHAR2,
soluong_ in VARCHAR2,
dateimport_ in DATE
) AS
i INTEGER := 0;
type r_cursor is REF CURSOR;
cursor_ r_cursor;
tuyenkenh_ TUYENKENH%rowtype;
BEGIN
  /*open cursor_ for select * from TUYENKENH_IMPORT where MADIEMDAU=madiemdau_ and MADIEMCUOI = madiemcuoi_ and GIAOTIEP_MA = giaotiep_ma_;
  fetch cursor_ into tuyenkenh_import_;
  if(cursor_%notfound = false) then --update
		update TUYENKENH_IMPORT set MADIEMDAU = madiemdau_, MADIEMCUOI = madiemcuoi_, GIAOTIEP_MA = giaotiep_ma_, DUAN_MA = duan_ma_, PHONGBAN_MA = phongban_ma_, KHUVUC_MA = khuvuc_ma_, DUNGLUONG = dungluong_, SOLUONG = soluong_,DATEIMPORT = dateimport_ where ID = tuyenkenh_import_.ID;
	else --insert
		i := SEQ_TUYENKENH_IMPORT.nextval;
		insert into TUYENKENH_IMPORT(STT,MADIEMDAU,MADIEMCUOI,GIAOTIEP_MA,DUAN_MA,PHONGBAN_MA,KHUVUC_MA,DUNGLUONG,SOLUONG,DATEIMPORT,ID) values (stt_,madiemdau_,madiemcuoi_,giaotiep_ma_,duan_ma_,phongban_ma_,khuvuc_ma_,dungluong_,soluong_,dateimport_,i);
	end if;
  close cursor_;*/
  open cursor_ for select t.* from TUYENKENH t left join LOAIGIAOTIEP t0 on t0.ID = t.GIAOTIEP_ID where t.DELETED = 0 and MADIEMDAU=madiemdau_ and MADIEMCUOI = madiemcuoi_ and t0.MA = giaotiep_ma_;
  i := SEQ_TUYENKENH_IMPORT.nextval;
  fetch cursor_ into tuyenkenh_;
  if(cursor_%notfound = false) then --duplicate tuyen kenh
		insert into TUYENKENH_IMPORT(STT,MADIEMDAU,MADIEMCUOI,GIAOTIEP_MA,DUAN_MA,PHONGBAN_MA,KHUVUC_MA,DUNGLUONG,SOLUONG,DATEIMPORT,ID,DUPLICATE) values (stt_,madiemdau_,madiemcuoi_,giaotiep_ma_,duan_ma_,phongban_ma_,khuvuc_ma_,dungluong_,soluong_,dateimport_,i,tuyenkenh_.ID);
	else --
		insert into TUYENKENH_IMPORT(STT,MADIEMDAU,MADIEMCUOI,GIAOTIEP_MA,DUAN_MA,PHONGBAN_MA,KHUVUC_MA,DUNGLUONG,SOLUONG,DATEIMPORT,ID) values (stt_,madiemdau_,madiemcuoi_,giaotiep_ma_,duan_ma_,phongban_ma_,khuvuc_ma_,dungluong_,soluong_,dateimport_,i);
	end if;
  close cursor_;
END SAVE_TUYENKENH_IMPORT;

/

--------------------------------------------------------
--  DDL for Function FIND_DEXUAT
--------------------------------------------------------

  CREATE OR REPLACE FUNCTION "THUEKENH"."FIND_DEXUAT" (
iDisplayStart IN NUMBER,   
iDisplayLength IN NUMBER, 
doitac_id_ in varchar2,
tenvanban_ in varchar2,
ngaygui_ in varchar2,
ngaydenghibangiao_ in varchar2,
trangthai_ in varchar2
) RETURN SYS_REFCURSOR AS
l_cursor SYS_REFCURSOR;
v_vcsql VARCHAR2(2000);
v_vcsqlwhere VARCHAR2(1000);
i NUMBER;
BEGIN
	v_vcsqlwhere := ' t.DELETED = 0 ';
	if(doitac_id_ is not null) then
		v_vcsqlwhere := v_vcsqlwhere ||' and t.DOITAC_ID = '||doitac_id_||' ';
	end if;
	if(trangthai_ is not null) then
		v_vcsqlwhere := v_vcsqlwhere ||' and t.TRANGTHAI = '||trangthai_||' ';
	end if;
	if(tenvanban_ is not null) then
		v_vcsqlwhere := v_vcsqlwhere ||' and t.TENVANBAN like '''||replace(tenvanban_, '*', '%')||''' ';
	end if;
	if(ngaydenghibangiao_ is not null) then
		v_vcsqlwhere := v_vcsqlwhere ||' and t.NGAYDENGHIBANGIAO = TO_DATE('''||ngaydenghibangiao_||''',''DD-MM-RRRR'') ';
	end if;
	if(ngaygui_ is not null) then
		v_vcsqlwhere := v_vcsqlwhere ||' and t.NGAYGUI = TO_DATE('''||ngaygui_||''',''DD-MM-RRRR'') ';
	end if;
	v_vcsql := 'select rownum as rn,dulieu.* from (SELECT t.ID,t.DOITAC_ID,t0.TENDOITAC,TENVANBAN,NGAYGUI,NGAYDENGHIBANGIAO,TRANGTHAI FROM DEXUAT t left join DOITAC t0 on t.DOITAC_ID = t0.ID WHERE ' || v_vcsqlwhere || ' order by t0.ID desc) dulieu ';
	v_vcsql := 'SELECT * FROM (' || v_vcsql || ') WHERE rn > ' || iDisplayStart || ' and rn <= ' || (iDisplayStart+iDisplayLength);
	--dbms_output.put_line(v_vcsql);
 --test(v_vcsql);
	OPEN l_cursor FOR v_vcsql;
	RETURN l_cursor;
END FIND_DEXUAT;

/

--------------------------------------------------------
--  DDL for Function FIND_TUYENKENHDEXUAT
--------------------------------------------------------

  CREATE OR REPLACE FUNCTION "THUEKENH"."FIND_TUYENKENHDEXUAT" (
iDisplayStart IN NUMBER,   
iDisplayLength IN NUMBER, 
makenh_ in varchar2,
loaigiaotiep_ in varchar2,
madiemdau_ in varchar2,
madiemcuoi_ in varchar2,
duan_ in varchar2,
khuvuc_ in varchar2,
phongban_ in varchar2,
ngaydenghibangiao_ in varchar2,
ngayhenbangiao_ in varchar2,
trangthai_ in varchar2,
dexuat_id_ in varchar2
) RETURN SYS_REFCURSOR AS
l_cursor SYS_REFCURSOR;
v_vcsql VARCHAR2(2000);
v_vcsqlwhere VARCHAR2(1000);
i NUMBER;
BEGIN
	v_vcsqlwhere := ' t.DELETED = 0 ';
  if(dexuat_id_ is not null) then
		v_vcsqlwhere := v_vcsqlwhere ||' and t.DEXUAT_ID = '||dexuat_id_||' ';
	end if;
	if(makenh_ is not null) then
		v_vcsqlwhere := v_vcsqlwhere ||' and t0.ID = '||makenh_||' ';
	end if;
	if(loaigiaotiep_ is not null) then
		v_vcsqlwhere := v_vcsqlwhere ||' and GIAOTIEP_ID = '||loaigiaotiep_||' ';
	end if;
	if(duan_ is not null) then
		v_vcsqlwhere := v_vcsqlwhere ||' and t0.DUAN_ID = '||duan_||' ';
	end if;
	if(khuvuc_ is not null) then
		v_vcsqlwhere := v_vcsqlwhere ||' and t0.KHUVUC_ID = '||khuvuc_||' ';
	end if;
	if(phongban_ is not null) then
		v_vcsqlwhere := v_vcsqlwhere ||' and t0.PHONGBAN_ID = '||phongban_||' ';
	end if;
	if(trangthai_ is not null) then
		if(trangthai_ = '-1') then -- tim kiem de xuat tuyen kenh chua co bien ban de xuat
			v_vcsqlwhere := v_vcsqlwhere ||' and t.DEXUAT_ID IS NULL  ';
		else
			v_vcsqlwhere := v_vcsqlwhere ||' and t.TRANGTHAI = '||trangthai_||' ';
		end if;
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
	v_vcsql := 'select rownum as rn,dulieu.* from (SELECT t.ID as ID,t0.ID as TUYENKENH_ID,MADIEMDAU,MADIEMCUOI,t1.LOAIGIAOTIEP,t0.DUNGLUONG,t.SOLUONG,t2.TENDUAN,t3.TENPHONGBAN,t4.TENKHUVUC,t.TRANGTHAI,t.NGAYDENGHIBANGIAO,t.NGAYHENBANGIAO FROM TUYENKENHDEXUAT t left join TUYENKENH t0 on t.TUYENKENH_ID = t0.ID left join LOAIGIAOTIEP t1 on t0.GIAOTIEP_ID = t1.ID left join DUAN t2 on t0.DUAN_ID = t2.ID left join PHONGBAN t3 on t0.PHONGBAN_ID = t3.ID left join KHUVUC t4 on t0.KHUVUC_ID=t4.ID WHERE ' || v_vcsqlwhere || ' order by t0.ID desc) dulieu ';
	v_vcsql := 'SELECT * FROM (' || v_vcsql || ') WHERE rn > ' || iDisplayStart || ' and rn <= ' || (iDisplayStart+iDisplayLength);
	--dbms_output.put_line(v_vcsql);
 --test(v_vcsql);
	OPEN l_cursor FOR v_vcsql;
	RETURN l_cursor;
END FIND_TUYENKENHDEXUAT;

/

--------------------------------------------------------
--  DDL for Function FIND_TUYENKENHIMPORT
--------------------------------------------------------

  CREATE OR REPLACE FUNCTION "THUEKENH"."FIND_TUYENKENHIMPORT" (
iDisplayStart IN NUMBER,   
iDisplayLength IN NUMBER
) RETURN SYS_REFCURSOR AS
l_cursor SYS_REFCURSOR;
v_vcsql VARCHAR2(2000);
i NUMBER;
BEGIN
	v_vcsql := 'select rownum as rn,dulieu.* from (SELECT t.ID,t.STT, t.MADIEMDAU, t.MADIEMCUOI, t.GIAOTIEP_MA, t.DUAN_MA, t.PHONGBAN_MA, t.KHUVUC_MA, t.DUNGLUONG, t.SOLUONG,TENDUAN,LOAIGIAOTIEP,TENPHONGBAN,TENKHUVUC,DUPLICATE FROM TUYENKENH_IMPORT t left join LOAIGIAOTIEP t0 on t.GIAOTIEP_MA = t0.MA left join DUAN t1 on t.DUAN_MA = t1.MA left join PHONGBAN t2 on t.PHONGBAN_MA = t2.MA left join KHUVUC t3 on t.KHUVUC_MA=t3.MA order by t.STT) dulieu ';
	v_vcsql := 'SELECT * FROM (' || v_vcsql || ') WHERE rn > ' || iDisplayStart || ' and rn <= ' || (iDisplayStart+iDisplayLength);
	--dbms_output.put_line(v_vcsql);
 --test(v_vcsql);
	OPEN l_cursor FOR v_vcsql;
	RETURN l_cursor;
END FIND_TUYENKENHIMPORT;

/

--------------------------------------------------------
--  DDL for Function FN_FIND_ACCOUNTS
--------------------------------------------------------

  CREATE OR REPLACE FUNCTION "THUEKENH"."FN_FIND_ACCOUNTS" (
iDisplayStart IN NUMBER,   
iDisplayLength IN NUMBER, 
username_ in varchar2,
phongban_ in varchar2,
khuvuc_ in varchar2,
active_ in varchar2
) RETURN SYS_REFCURSOR AS
l_cursor SYS_REFCURSOR;
v_vcsql VARCHAR2(1000);
v_vcsqlwhere VARCHAR2(500);
i NUMBER;
BEGIN
	v_vcsqlwhere := ' 1 = 1 ';
	if(username_ is not null) then
		v_vcsqlwhere := v_vcsqlwhere ||' and USERNAME like '''||username_||'%'' ';
	end if;
	if(phongban_ is not null) then
		v_vcsqlwhere := v_vcsqlwhere ||' and IDPHONGBAN = '||phongban_||' ';
	end if;
	if(khuvuc_ is not null) then
		v_vcsqlwhere := v_vcsqlwhere ||' and IDKHUVUC = '||khuvuc_||' ';
	end if;
	if(active_ is not null) then
		v_vcsqlwhere := v_vcsqlwhere ||' and t0.ACTIVE = '||active_||' ';
	end if;
	v_vcsql := 'select rownum as rn,dulieu.* from (SELECT t0.ID,USERNAME,PASSWORD,IDGROUP,t0.ACTIVE,IDKHUVUC,IDPHONGBAN,TENPHONGBAN,TENKHUVUC,NAMEMENU FROM ACCOUNTS t0 left join PHONGBAN t1 on t0.IDPHONGBAN = t1.ID left join KHUVUC t2 on t0.IDKHUVUC = t2.ID left join MENU t3 on t0.MAINMENU = t3.ID  WHERE ' || v_vcsqlwhere || ' order by ID desc) dulieu ';
	v_vcsql := 'SELECT * FROM (' || v_vcsql || ') WHERE rn > ' || iDisplayStart || ' and rn <= ' || (iDisplayStart+iDisplayLength);
	--dbms_output.put_line(v_vcsql);
 --test(v_vcsql);
	OPEN l_cursor FOR v_vcsql;
	RETURN l_cursor;
END FN_FIND_ACCOUNTS;

/

--------------------------------------------------------
--  DDL for Function FN_FIND_TUYENKENH
--------------------------------------------------------

  CREATE OR REPLACE FUNCTION "THUEKENH"."FN_FIND_TUYENKENH" (
iDisplayStart IN NUMBER,   
iDisplayLength IN NUMBER, 
makenh_ in varchar2,
loaigiaotiep_ in varchar2,
madiemdau_ in varchar2,
madiemcuoi_ in varchar2,
duan_ in varchar2,
khuvuc_ in varchar2,
phongban_ in varchar2,
ngaydenghibangiao_ in varchar2,
ngayhenbangiao_ in varchar2,
trangthai_ in varchar2
) RETURN SYS_REFCURSOR AS
l_cursor SYS_REFCURSOR;
v_vcsql VARCHAR2(2000);
v_vcsqlwhere VARCHAR2(1000);
i NUMBER;
BEGIN
	v_vcsqlwhere := ' t0.DELETED = 0 ';
	if(makenh_ is not null) then
		v_vcsqlwhere := v_vcsqlwhere ||' and t0.ID = '||makenh_||' ';
	end if;
	if(loaigiaotiep_ is not null) then
		v_vcsqlwhere := v_vcsqlwhere ||' and GIAOTIEP_ID = '||loaigiaotiep_||' ';
	end if;
	if(duan_ is not null) then
		v_vcsqlwhere := v_vcsqlwhere ||' and DUAN_ID = '||duan_||' ';
	end if;
	if(khuvuc_ is not null) then
		v_vcsqlwhere := v_vcsqlwhere ||' and t0.KHUVUC_ID = '||khuvuc_||' ';
	end if;
	if(phongban_ is not null) then
		v_vcsqlwhere := v_vcsqlwhere ||' and PHONGBAN_ID = '||phongban_||' ';
	end if;
	if(trangthai_ is not null) then
		v_vcsqlwhere := v_vcsqlwhere ||' and TRANGTHAI = '||trangthai_||' ';
	end if;
	if(madiemdau_ is not null) then
    
		v_vcsqlwhere := v_vcsqlwhere ||' and MADIEMDAU like '''||replace(madiemdau_, '*', '%')||''' ';
	end if;
	if(madiemcuoi_ is not null) then
		v_vcsqlwhere := v_vcsqlwhere ||' and MADIEMCUOI like '''||replace(madiemcuoi_, '*', '%')||''' ';
	end if;
	if(ngaydenghibangiao_ is not null) then
		v_vcsqlwhere := v_vcsqlwhere ||' and NGAYDENGHIBANGIAO = TO_DATE('''||ngaydenghibangiao_||''',''DD-MM-RRRR'') ';
	end if;
	if(ngayhenbangiao_ is not null) then
		v_vcsqlwhere := v_vcsqlwhere ||' and NGAYHENBANGIAO = TO_DATE('''||ngayhenbangiao_||''',''DD-MM-RRRR'') ';
	end if;
	v_vcsql := 'select rownum as rn,dulieu.* from (SELECT t0.ID,MADIEMDAU,MADIEMCUOI,t1.LOAIGIAOTIEP,t0.DUNGLUONG,t0.SOLUONG,t2.TENDUAN,t0.GIAOTIEP_ID,t0.DUAN_ID,t0.PHONGBAN_ID,t0.KHUVUC_ID,t3.TENPHONGBAN,t4.TENKHUVUC,t0.TRANGTHAI FROM TUYENKENH t0 left join LOAIGIAOTIEP t1 on t0.GIAOTIEP_ID = t1.ID left join DUAN t2 on t0.DUAN_ID = t2.ID left join PHONGBAN t3 on t0.PHONGBAN_ID = t3.ID left join KHUVUC t4 on t0.KHUVUC_ID=t4.ID WHERE ' || v_vcsqlwhere || ' order by t0.ID desc) dulieu ';
	v_vcsql := 'SELECT * FROM (' || v_vcsql || ') WHERE rn > ' || iDisplayStart || ' and rn <= ' || (iDisplayStart+iDisplayLength);
	--dbms_output.put_line(v_vcsql);
 --test(v_vcsql);
	OPEN l_cursor FOR v_vcsql;
	RETURN l_cursor;
END FN_FIND_TUYENKENH;

/

--------------------------------------------------------
--  DDL for Function GETLISTMENU
--------------------------------------------------------

  CREATE OR REPLACE FUNCTION "THUEKENH"."GETLISTMENU" (
idaccount_ in number,
idgroup_ in varchar2
) RETURN CLOB AS 
----========================================================================
-- @project: VMS quan ly kenh truyen dan
-- @description: Lay danh sach menu cua user, tra ve dang chuoi HTML
-- @author	nclong
-- @date Feb 16, 2012
-- @param
-- @vesion 1.0
-- @copyright nclong
---- @date update 
---- @user update
---- @note: 
----========================================================================
TYPE table_menu_bulk IS TABLE OF MENU%ROWTYPE;
tableMenu table_menu_bulk := table_menu_bulk();
vc_sql varchar2(2000);
clob_return clob;
vc_tmp varchar2(4000);
num number;
BEGIN
	clob_return := '<ul class="sf-menu">';
	vc_sql:= 'select m.* from menu m,user_menu u where m.active = 1 and m.id=u.menuid and accountid='||idaccount_||' union select t3.* from group_menu t1,vmsgroup t2,menu t3 where t3.active = 1 and t1.idmenu=t3.id and t1.idgroup=t2.id  and t2.active=1 and t2.id='''||idgroup_||''' ';
	EXECUTE IMMEDIATE vc_sql BULK COLLECT INTO tableMenu ; 
  if(tableMenu.count()>0) then
	for rec in (select ID,NAME from ROOTMENU) loop
		vc_tmp := null;
    num := 0;
		for n in tableMenu.first .. tableMenu.last loop
			if(rec.ID = tableMenu(n).IDROOTMENU) then
				--DBMS_LOB.append (clob_return,'<li>');
				vc_tmp := vc_tmp||'<li><a href="#" onclick="loadContent('''||tableMenu(n).ACTION||''')">'||tableMenu(n).NAMEMENU||'</a></li>';
        num := num + 1;
      end if;
			--DBMS_OUTPUT.PUT_LINE(tableMenu(n).NAMEMENU);
		end loop;
		
		if(num > 1) then 
			vc_tmp := '<li><a href="#a">'||rec.NAME||'</a><ul>'||vc_tmp||'</ul></li>';
			DBMS_LOB.append (clob_return,vc_tmp);
    elsif (num = 1) then
      DBMS_LOB.append (clob_return,vc_tmp);
		end if;
	end loop;
  end if;
	DBMS_LOB.append (clob_return,'</ul>');
	--DBMS_OUTPUT.PUT_LINE(clob_return);
	RETURN clob_return;
END GETLISTMENU;

/

--------------------------------------------------------
--  DDL for Function SAVE_ACCOUNT
--------------------------------------------------------

  CREATE OR REPLACE FUNCTION "THUEKENH"."SAVE_ACCOUNT" 
(
	id_	in VARCHAR2,
	username_ in VARCHAR2,
	password_ in VARCHAR2,
	active_ in NUMBER,
	idkhuvuc_ in NUMBER,
	idphongban_ in NUMBER,
  idgroup_ in varchar2,
  mainmenu_ in varchar2
)
RETURN NUMBER AS
n NUMBER;
BEGIN
	if(id_ is not null) then --update
    if(password_ is not null) then
      update ACCOUNTS set IDGROUP = idgroup_, PASSWORD = password_, ACTIVE = active_, IDKHUVUC = idkhuvuc_, IDPHONGBAN = idphongban_, MAINMENU = mainmenu_ where ID = to_number(id_);
    else
      update ACCOUNTS set IDGROUP = idgroup_, ACTIVE = active_, IDKHUVUC = idkhuvuc_, IDPHONGBAN = idphongban_ where ID = to_number(id_);
    end if;
	else --insert
		n := SEQ_ACCOUNTS.nextval;
		insert into ACCOUNTS(ID,USERNAME,PASSWORD,IDGROUP,ACTIVE,IDKHUVUC,IDPHONGBAN,MAINMENU) values (n,username_,password_, idgroup_, active_,idkhuvuc_,idphongban_,mainmenu_);
    return n;
  end if;
  RETURN id_;
END SAVE_ACCOUNT;

/

--------------------------------------------------------
--  DDL for Function SAVE_DEXUAT
--------------------------------------------------------

  CREATE OR REPLACE FUNCTION "THUEKENH"."SAVE_DEXUAT" (
id_ in VARCHAR2,
doitac_id_ in VARCHAR2,
filename_ in VARCHAR2,
tenvanban_ in VARCHAR2,
ngaygui_ in VARCHAR2,
ngaydenghibangiao_ in VARCHAR2,
thongtinthem_ in VARCHAR2,
usercreate_ in VARCHAR2,
timecreate_ in VARCHAR2,
trangthai_ in VARCHAR2,
filepath_ in VARCHAR2,
filesize_ in VARCHAR2
) RETURN NUMBER AS
i INTEGER := 0;
BEGIN
	if(id_ is not null and id_>0) then --update
		update DEXUAT set DOITAC_ID = doitac_id_,FILENAME = filename_,FILEPATH = filepath_,FILESIZE = filesize_,TENVANBAN = tenvanban_,NGAYGUI = ngaygui_,NGAYDENGHIBANGIAO = ngaydenghibangiao_,THONGTINTHEM = thongtinthem_,TRANGTHAI = trangthai_ where ID = id_;
		update TUYENKENHDEXUAT set DEXUAT_ID = null where DEXUAT_ID = id_;
		i := id_;
	else --insert
		i:=SEQ_DEXUAT.nextval;
		
		insert into DEXUAT(ID, DOITAC_ID, TENVANBAN, NGAYGUI, NGAYDENGHIBANGIAO, THONGTINTHEM, HISTORY, USERCREATE, TIMECREATE, DELETED, TRANGTHAI,FILENAME,FILEPATH,FILESIZE) values (i, doitac_id_, tenvanban_, ngaygui_, ngaydenghibangiao_, thongtinthem_, '', usercreate_, timecreate_, 0, trangthai_,filename_,filepath_,filesize_);
	end if;
	return i;
END SAVE_DEXUAT;

/

--------------------------------------------------------
--  DDL for Function SAVE_TUYENKENH
--------------------------------------------------------

  CREATE OR REPLACE FUNCTION "THUEKENH"."SAVE_TUYENKENH" (
id_ in VARCHAR2,
diemdau_id_ in VARCHAR2,
diemcuoi_id_ in VARCHAR2,
giaotiep_id_ in VARCHAR2,
duan_id_ in VARCHAR2,
phongban_id_ in VARCHAR2,
khuvuc_id_ in VARCHAR2,
dungluong_ in VARCHAR2,
soluong_ in VARCHAR2,
trangthai_ in VARCHAR2,
usercreate_ in VARCHAR2,
timecreate_ in VARCHAR2,
deleted_ in VARCHAR2
) RETURN NUMBER AS
i INTEGER := 0;
BEGIN
	if(id_ is not null and id_>0) then --update
		update TUYENKENH set DUAN_ID = duan_id_,PHONGBAN_ID = phongban_id_,KHUVUC_ID = khuvuc_id_,DUNGLUONG = dungluong_,SOLUONG = soluong_,TRANGTHAI = trangthai_ where ID = id_;
		i := id_;
	else --insert
		i:=SEQ_TUYENKENH.nextval;
		
		insert into TUYENKENH(ID, MADIEMDAU, MADIEMCUOI, GIAOTIEP_ID, DUAN_ID, PHONGBAN_ID, KHUVUC_ID, DUNGLUONG, SOLUONG, TRANGTHAI, USERCREATE, TIMECREATE, DELETED) values (i, diemdau_id_, diemcuoi_id_, giaotiep_id_, duan_id_, phongban_id_, khuvuc_id_, dungluong_, soluong_, trangthai_, usercreate_, timecreate_, 0);
	end if;
	return i;
END SAVE_TUYENKENH;

/

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
khuvuc_id_ in VARCHAR2,
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
id_tuyenkenh number := 0;
BEGIN
	if(tuyenkenh_id_ is not null and tuyenkenh_id_>0) then --update
		update TUYENKENH set DUAN_ID = duan_id_,PHONGBAN_ID = phongban_id_,KHUVUC_ID = khuvuc_id_,DUNGLUONG = dungluong_,SOLUONG = SOLUONG + (soluong_ - soluong_old),TRANGTHAI_BAK = TRANGTHAI, TRANGTHAI = 2  where ID = tuyenkenh_id_ and DELETED = 0;
		id_tuyenkenh := tuyenkenh_id_;
	else --insert
		id_tuyenkenh:=SEQ_TUYENKENH.nextval;
		insert into TUYENKENH(ID, MADIEMDAU, MADIEMCUOI, GIAOTIEP_ID, DUAN_ID, PHONGBAN_ID, KHUVUC_ID, DUNGLUONG, SOLUONG, TRANGTHAI, USERCREATE, TIMECREATE, DELETED) values (id_tuyenkenh, madiemdau_, madiemcuoi_, giaotiep_id_, duan_id_, phongban_id_, khuvuc_id_, dungluong_, soluong_, 1, usercreate_, timecreate_, 0);
	end if;
	if(id_ is not null and id_>0) then --update
		update TUYENKENHDEXUAT set TUYENKENH_ID = id_tuyenkenh,NGAYDENGHIBANGIAO = ngaydenghibangiao_,NGAYHENBANGIAO = ngayhenbangiao_,THONGTINLIENHE = thongtinlienhe_,SOLUONG = soluong_ where ID = id_;
		i := id_;
	else --insert
		i:=SEQ_TUYENKENHDEXUAT.nextval;
		insert into TUYENKENHDEXUAT(ID, DEXUAT_ID, TUYENKENH_ID, BANGIAO_ID, NGAYDENGHIBANGIAO, NGAYHENBANGIAO, THONGTINLIENHE, TRANGTHAI, SOLUONG) values (i, NULL, id_tuyenkenh, NULL, ngaydenghibangiao_, ngayhenbangiao_, thongtinlienhe_, 0, soluong_);
	end if;
	return i;
END SAVE_TUYENKENHDEXUAT;

/

--------------------------------------------------------
--  DDL for Function SAVE_VMSGROUP
--------------------------------------------------------

  CREATE OR REPLACE FUNCTION "THUEKENH"."SAVE_VMSGROUP" 
(
	id_	in VARCHAR2,
	namegroup_ in VARCHAR2,
  mainmenu_ in VARCHAR2
)
RETURN NUMBER AS
n NUMBER;
BEGIN
	if(id_ is not null) then --update
      update VMSGROUP set NAMEGROUP = namegroup_, MAINMENU = mainmenu_ where ID = to_number(id_);
	else --insert
		n := SEQ_VMSGROUP.nextval;
		insert into VMSGROUP(ID,NAMEGROUP,ACTIVE,MAINMENU) values (n,namegroup_,1,mainmenu_);
    return n;
  end if;
  RETURN id_;
END SAVE_VMSGROUP;

/



