ALTER TABLE TUYENKENH  
MODIFY (ID VARCHAR(20) );

ALTER TABLE CHITIETPHULUC_TUYENKENH  
MODIFY (TUYENKENH_ID VARCHAR(20) );

ALTER TABLE SUCO_IMPORT  
MODIFY (TUYENKENH_ID VARCHAR(20) );

ALTER TABLE SUCOKENH  
MODIFY (TUYENKENH_ID VARCHAR(20) );

ALTER TABLE TUYENKENH_HISTORY  
MODIFY (TUYENKENH_ID VARCHAR(20) );

ALTER TABLE TUYENKENHDEXUAT  
MODIFY (TUYENKENH_ID VARCHAR(20) );

ALTER TABLE TUYENKENH RENAME COLUMN KHUVUC_ID TO DOITAC_ID;
ALTER TABLE TUYENKENH_IMPORT RENAME COLUMN KHUVUC_MA TO DOITAC_MA;

ALTER TABLE DOITAC 
ADD (KHUVUC_ID NUMBER );

ALTER TABLE TUYENKENH_IMPORT 
ADD (TRANGTHAI NUMBER );

ALTER TABLE DOITAC 
ADD (SOTUYENKENH NUMBER DEFAULT 0 );

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
id_tuyenkenh number := 0;
BEGIN
	if(tuyenkenh_id_ is not null and tuyenkenh_id_>0) then --update
		update TUYENKENH set DUAN_ID = duan_id_,PHONGBAN_ID = phongban_id_,DOITAC_ID = doitac_id_,DUNGLUONG = dungluong_,SOLUONG = SOLUONG + (soluong_ - soluong_old),TRANGTHAI_BAK = TRANGTHAI, TRANGTHAI = 2  where ID = tuyenkenh_id_ and DELETED = 0;
		id_tuyenkenh := tuyenkenh_id_;
	else --insert
		i:=GET_SOTUYENKENH(doitac_id_) + 1;
    select ma into madoitac from doitac where id = doitac_id_;
    matuyenkenh := madoitac||'_'||TRIM(to_char(i,'0009'));
		insert into TUYENKENH(ID, MADIEMDAU, MADIEMCUOI, GIAOTIEP_ID, DUAN_ID, PHONGBAN_ID, DOITAC_ID, DUNGLUONG, SOLUONG, TRANGTHAI, USERCREATE, TIMECREATE, DELETED) values (matuyenkenh, madiemdau_, madiemcuoi_, giaotiep_id_, duan_id_, phongban_id_, doitac_id_, dungluong_, soluong_, 1, usercreate_, timecreate_, 0);
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
--  DDL for Function SAVE_TUYENKENH
--------------------------------------------------------

  CREATE OR REPLACE FUNCTION "THUEKENH"."SAVE_TUYENKENH" (
id_ in VARCHAR2,
diemdau_id_ in VARCHAR2,
diemcuoi_id_ in VARCHAR2,
giaotiep_id_ in VARCHAR2,
duan_id_ in VARCHAR2,
phongban_id_ in VARCHAR2,
doitac_id_ in VARCHAR2,
dungluong_ in VARCHAR2,
soluong_ in VARCHAR2,
trangthai_ in VARCHAR2,
usercreate_ in VARCHAR2,
timecreate_ in VARCHAR2,
deleted_ in VARCHAR2
) RETURN NUMBER AS
i INTEGER := 0;
madoitac varchar2(50);
matuyenkenh varchar2(20);
BEGIN
	if(id_ is not null and id_>0) then --update
		update TUYENKENH set DUAN_ID = duan_id_,PHONGBAN_ID = phongban_id_,DOITAC_ID = doitac_id_,DUNGLUONG = dungluong_,SOLUONG = soluong_,TRANGTHAI = trangthai_ where ID = id_;
		i := id_;
	else --insert
    select ma into madoitac from doitac where id = doitac_id_;
		i:=GET_SOTUYENKENH(doitac_id_) + 1;
		matuyenkenh := madoitac||'_'||TRIM(to_char(i,'0009'));
		insert into TUYENKENH(ID, MADIEMDAU, MADIEMCUOI, GIAOTIEP_ID, DUAN_ID, PHONGBAN_ID, DOITAC_ID, DUNGLUONG, SOLUONG, TRANGTHAI, USERCREATE, TIMECREATE, DELETED) values (matuyenkenh, diemdau_id_, diemcuoi_id_, giaotiep_id_, duan_id_, phongban_id_, doitac_id_, dungluong_, soluong_, trangthai_, usercreate_, timecreate_, 0);
  end if;
	return i;
END SAVE_TUYENKENH;

/

--------------------------------------------------------
--  DDL for Function GET_SOTUYENKENH
--------------------------------------------------------

  CREATE OR REPLACE FUNCTION "THUEKENH"."GET_SOTUYENKENH" (doitac_id in number) RETURN NUMBER AS 
rs number;
BEGIN
  select SOTUYENKENH into rs from DOITAC where ID = doitac_id;
  RETURN rs;
END GET_SOTUYENKENH;

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
doitac_ in varchar2,
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
	if(doitac_ is not null) then
		v_vcsqlwhere := v_vcsqlwhere ||' and t0.DOITAC_ID = '||doitac_||' ';
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
	v_vcsql := 'select rownum as rn,dulieu.* from (SELECT t0.ID,MADIEMDAU,MADIEMCUOI,t1.LOAIGIAOTIEP,t0.DUNGLUONG,t0.SOLUONG,t2.TENDUAN,t0.GIAOTIEP_ID,t0.DUAN_ID,t0.PHONGBAN_ID,t0.DOITAC_ID,t3.TENPHONGBAN,t4.TENDOITAC,t0.TRANGTHAI FROM TUYENKENH t0 left join LOAIGIAOTIEP t1 on t0.GIAOTIEP_ID = t1.ID left join DUAN t2 on t0.DUAN_ID = t2.ID left join PHONGBAN t3 on t0.PHONGBAN_ID = t3.ID left join DOITAC t4 on t0.DOITAC_ID=t4.ID WHERE ' || v_vcsqlwhere || ' order by t0.ID desc) dulieu ';
	v_vcsql := 'SELECT * FROM (' || v_vcsql || ') WHERE rn > ' || iDisplayStart || ' and rn <= ' || (iDisplayStart+iDisplayLength);
	--dbms_output.put_line(v_vcsql);
 test(v_vcsql);
	OPEN l_cursor FOR v_vcsql;
	RETURN l_cursor;
END FN_FIND_TUYENKENH;

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
	v_vcsql := 'select rownum as rn,dulieu.* from (SELECT t.ID,t.STT, t.MADIEMDAU, t.MADIEMCUOI, t.GIAOTIEP_MA, t.DUAN_MA, t.PHONGBAN_MA, t.DOITAC_MA, t.DUNGLUONG, t.SOLUONG,TENDUAN,LOAIGIAOTIEP,TENPHONGBAN,TENDOITAC,DUPLICATE,t.TRANGTHAI FROM TUYENKENH_IMPORT t left join LOAIGIAOTIEP t0 on t.GIAOTIEP_MA = t0.MA left join DUAN t1 on t.DUAN_MA = t1.MA left join PHONGBAN t2 on t.PHONGBAN_MA = t2.MA left join DOITAC t3 on t.DOITAC_MA=t3.MA order by t.STT) dulieu ';
	v_vcsql := 'SELECT * FROM (' || v_vcsql || ') WHERE rn > ' || iDisplayStart || ' and rn <= ' || (iDisplayStart+iDisplayLength);
	--dbms_output.put_line(v_vcsql);
 --test(v_vcsql);
	OPEN l_cursor FOR v_vcsql;
	RETURN l_cursor;
END FIND_TUYENKENHIMPORT;

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
dexuat_id_ in varchar2,
bangiao_id in varchar2
) RETURN SYS_REFCURSOR AS
l_cursor SYS_REFCURSOR;
v_vcsql VARCHAR2(2000);
v_vcsqlwhere VARCHAR2(1000);
i NUMBER;
BEGIN
	v_vcsqlwhere := ' t.DELETED = 0 ';
  if(bangiao_id is not null) then
		v_vcsqlwhere := v_vcsqlwhere ||' and t.BANGIAO_ID = '||bangiao_id||' ';
	end if;
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
khuvuc_id in varchar2,
phongban_id in varchar2,
isAllow in varchar2
) RETURN SYS_REFCURSOR AS
l_cursor SYS_REFCURSOR;
v_vcsql VARCHAR2(2000);
v_vcsqlwhere VARCHAR2(1000);
i NUMBER;
BEGIN
	v_vcsqlwhere := ' t.DELETED = 0 ';--and t0.khuvuc_id='''||khuvuc_id||'''';
  if(isAllow = '0' ) then
		v_vcsqlwhere := v_vcsqlwhere || 'and t0.khuvuc_id='''||khuvuc_id||''' and t0.PHONGBAN_ID ='''||phongban_id||'''';
	end if;
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
	v_vcsql := 'select rownum as rn,dulieu.* from (
              SELECT t.ID as ID,t0.ID as TUYENKENH_ID,MADIEMDAU,MADIEMCUOI,t1.LOAIGIAOTIEP,t0.giaotiep_id,t0.DUAN_ID,t0.DUNGLUONG,t.SOLUONG,dx.tenvanban as tenvanbandexuat,t2.tenduan,tiendo,dx.id as MAVANBANDEXUAT,TENPHONGBAN,TENKHUVUC
              FROM TUYENKENHDEXUAT t 
              left join TUYENKENH t0 on t.TUYENKENH_ID = t0.ID 
              left join LOAIGIAOTIEP t1 on t0.GIAOTIEP_ID = t1.ID 
              left join DUAN t2 on t0.DUAN_ID = t2.ID 
              left join PHONGBAN t3 on t0.PHONGBAN_ID = t3.ID
              left join KHUVUC t4 on t0.KHUVUC_ID = t4.ID
              left join dexuat dx on dx.id=t.dexuat_id
              where  t.trangthai=0 and '|| v_vcsqlwhere || ' order by t0.ID desc) dulieu ';
	v_vcsql := 'SELECT * FROM (' || v_vcsql || ') WHERE rn >= ' || iDisplayStart || ' and rn <= ' || (iDisplayStart+iDisplayLength);
	--dbms_output.put_line(v_vcsql);
 test(v_vcsql);
	OPEN l_cursor FOR v_vcsql;
	RETURN l_cursor;
END FIND_TUYENKENHBANGIAO;

/

--------------------------------------------------------
--  DDL for Function FIND_SUCOIMPORT
--------------------------------------------------------

  CREATE OR REPLACE FUNCTION "THUEKENH"."FIND_SUCOIMPORT" (
iDisplayStart IN NUMBER,   
iDisplayLength IN NUMBER
) RETURN SYS_REFCURSOR AS
l_cursor SYS_REFCURSOR;
v_vcsql VARCHAR2(2000);
i NUMBER;
BEGIN
	v_vcsql := 'select rownum as rn,dulieu.* from (SELECT t.ID,t.STT, t.MADIEMDAU, t.MADIEMCUOI,t.DUNGLUONG, t.MAGIAOTIEP, t.THOIDIEMBATDAU, t.THOIDIEMKETTHUC, t.NGUYENNHAN, t.PHUONGANXULY, t.TUYENKENH_ID,t.NGUOIXACNHAN,t0.LOAIGIAOTIEP FROM SUCO_IMPORT t left join LOAIGIAOTIEP t0 on t.MAGIAOTIEP = t0.MA  order by t.STT) dulieu ';
	v_vcsql := 'SELECT * FROM (' || v_vcsql || ') WHERE rn > ' || iDisplayStart || ' and rn <= ' || (iDisplayStart+iDisplayLength);
	--dbms_output.put_line(v_vcsql);
 --test(v_vcsql);
	OPEN l_cursor FOR v_vcsql;
	RETURN l_cursor;
END FIND_SUCOIMPORT;

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
--  DDL for Function FIND_BANGIAO
--------------------------------------------------------

  CREATE OR REPLACE FUNCTION "THUEKENH"."FIND_BANGIAO" (
iDisplayStart IN NUMBER,   
iDisplayLength IN NUMBER, 
sobienban_ in varchar2
) RETURN SYS_REFCURSOR AS
l_cursor SYS_REFCURSOR;
v_vcsql VARCHAR2(2000);
i NUMBER;
BEGIN
if(sobienban_ is null) then
	v_vcsql := 'select rownum as rn,dulieu.* from (select * from bangiao where deleted=0) dulieu ';
  else
  	v_vcsql := 'select rownum as rn,dulieu.* from (select * from bangiao where deleted=0 and sobienban like ''%'|| sobienban_ ||'%'') dulieu ';
end if;
	v_vcsql := 'SELECT * FROM (' || v_vcsql || ') WHERE rn > ' || iDisplayStart || ' and rn <= ' || (iDisplayStart+iDisplayLength);
	--dbms_output.put_line(v_vcsql);
 --test(v_vcsql);
	OPEN l_cursor FOR v_vcsql;
	RETURN l_cursor;
END FIND_BANGIAO;

/

--------------------------------------------------------
--  DDL for Procedure CLEAR_DATA
--------------------------------------------------------
set define off;

  CREATE OR REPLACE PROCEDURE "THUEKENH"."CLEAR_DATA" AS 
BEGIN
  execute immediate 'truncate table "THUEKENH"."TUYENKENH" drop storage';
  execute immediate 'truncate table "THUEKENH"."BANGIAO" drop storage';
  execute immediate 'truncate table "THUEKENH"."BIENBANVANHANH" drop storage';
  execute immediate 'truncate table "THUEKENH"."DEXUAT" drop storage';
  execute immediate 'truncate table "THUEKENH"."SUCO_IMPORT" drop storage';
  execute immediate 'truncate table "THUEKENH"."SUCOKENH" drop storage';
  execute immediate 'truncate table "THUEKENH"."TUYENKENH_IMPORT" drop storage';
  execute immediate 'truncate table "THUEKENH"."TUYENKENH_TIEUCHUAN" drop storage';
  execute immediate 'truncate table "THUEKENH"."TUYENKENHDEXUAT" drop storage';
  execute immediate 'truncate table "THUEKENH"."VANHANH_SUCOKENH" drop storage';
  reset_seq('SEQ_BANGIAO');
  reset_seq('SEQ_BIENBANVANHANH');
  reset_seq('SEQ_DEXUAT');
  reset_seq('SEQ_SUCO');
  reset_seq('SEQ_SUCOIMPORT');
  reset_seq('SEQ_TUYENKENH');
  reset_seq('SEQ_TUYENKENH_IMPORT');
  reset_seq('SEQ_TUYENKENHDEXUAT');
  update DOITAC set SOTUYENKENH = 0;
END CLEAR_DATA;

/

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
madoitac varchar2(50);
matuyenkenh varchar2(20);
BEGIN
	for rec in (SELECT t.ID,t.MADIEMDAU, t.MADIEMCUOI, t0.ID as GIAOTIEP_ID, t1.ID as DUAN_ID, t2.ID as PHONGBAN_ID, t3.ID as DOITAC_ID, t.DUNGLUONG, t.SOLUONG,DUPLICATE,DOITAC_MA,t.TRANGTHAI FROM TUYENKENH_IMPORT t left join LOAIGIAOTIEP t0 on t.GIAOTIEP_MA = t0.MA left join DUAN t1 on t.DUAN_MA = t1.MA left join PHONGBAN t2 on t.PHONGBAN_MA = t2.MA left join DOITAC t3 on t.DOITAC_MA=t3.MA where t.ID in (select * from table(pi_array))) loop
		if(rec.DUPLICATE != 0) then --duplicate => update tuyenkenh
			update TUYENKENH set MADIEMDAU = rec.MADIEMDAU, MADIEMCUOI = rec.MADIEMCUOI, GIAOTIEP_ID = rec.GIAOTIEP_ID, DUAN_ID = rec.DUAN_ID, PHONGBAN_ID = rec.PHONGBAN_ID, DOITAC_ID = rec.DOITAC_ID, DUNGLUONG = rec.DUNGLUONG, SOLUONG = rec.SOLUONG, TRANGTHAI = rec.TRANGTHAI where ID = rec.DUPLICATE;
		else --insert
      i:=GET_SOTUYENKENH(rec.DOITAC_ID) + 1;
      matuyenkenh := rec.DOITAC_MA||'_'||TRIM(to_char(i,'0009'));
			insert into TUYENKENH(ID,MADIEMDAU,MADIEMCUOI,GIAOTIEP_ID,DUAN_ID,PHONGBAN_ID,DOITAC_ID,DUNGLUONG,TRANGTHAI,USERCREATE,TIMECREATE,DELETED,SOLUONG,TRANGTHAI_BAK) values (matuyenkenh,rec.MADIEMDAU,rec.MADIEMCUOI,rec.GIAOTIEP_ID,rec.DUAN_ID,rec.PHONGBAN_ID,rec.DOITAC_ID,rec.DUNGLUONG,rec.TRANGTHAI,usercreate_,timecreate_,0,rec.SOLUONG,0);
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
doitac_ma_ in VARCHAR2,
dungluong_ in VARCHAR2,
soluong_ in VARCHAR2,
trangthai_ in VARCHAR2,
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
		insert into TUYENKENH_IMPORT(STT,MADIEMDAU,MADIEMCUOI,GIAOTIEP_MA,DUAN_MA,PHONGBAN_MA,DOITAC_MA,DUNGLUONG,SOLUONG,DATEIMPORT,ID,DUPLICATE,TRANGTHAI) values (stt_,madiemdau_,madiemcuoi_,giaotiep_ma_,duan_ma_,phongban_ma_,doitac_ma_,dungluong_,soluong_,dateimport_,i,tuyenkenh_.ID,trangthai_);
	else --
		insert into TUYENKENH_IMPORT(STT,MADIEMDAU,MADIEMCUOI,GIAOTIEP_MA,DUAN_MA,PHONGBAN_MA,DOITAC_MA,DUNGLUONG,SOLUONG,DATEIMPORT,ID,TRANGTHAI) values (stt_,madiemdau_,madiemcuoi_,giaotiep_ma_,duan_ma_,phongban_ma_,doitac_ma_,dungluong_,soluong_,dateimport_,i,trangthai_);
	end if;
  close cursor_;
END SAVE_TUYENKENH_IMPORT;

/

--------------------------------------------------------
--  DDL for Trigger INSERT_TUYENKENH
--------------------------------------------------------

  CREATE OR REPLACE TRIGGER "THUEKENH"."INSERT_TUYENKENH" 
AFTER INSERT ON TUYENKENH FOR EACH ROW
BEGIN
  UPDATE DOITAC SET SOTUYENKENH = SOTUYENKENH + 1 WHERE ID = :NEW.DOITAC_ID;
END;
/
ALTER TRIGGER "THUEKENH"."INSERT_TUYENKENH" ENABLE;
