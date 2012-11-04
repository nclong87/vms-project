ALTER TABLE PHULUC  
MODIFY (DELETED NUMBER DEFAULT 0 );

ALTER TABLE PHULUC 
ADD (CUOCDAUNOI NUMBER DEFAULT 0 );

ALTER TABLE PHULUC 
ADD (GIATRITRUOCTHUE NUMBER DEFAULT 0 );

ALTER TABLE PHULUC 
ADD (GIATRISAUTHUE NUMBER DEFAULT 0 );

ALTER TABLE PHULUC 
ADD (SOLUONGKENH VARCHAR2(100) );

drop table "THUEKENH"."PHULUCTHAYTHE" cascade constraints ;

ALTER TABLE CHITIETPHULUC_TUYENKENH 
ADD (PHULUC_ID NUMBER );

--------------------------------------------------------
--  DDL for Procedure PROC_SAVE_CTPL_TUYENKENH_TMP
--------------------------------------------------------
set define off;

  CREATE OR REPLACE PROCEDURE "THUEKENH"."PROC_SAVE_CTPL_TUYENKENH_TMP" (
tuyenkenh_id_ in VARCHAR2,
congthuc_id_ in VARCHAR2,
soluong_ in NUMBER,
cuoccong_ in NUMBER,
cuocdaunoi_ in NUMBER,
dongia_ in NUMBER,
giamgia_ in NUMBER,
thanhtien_ in NUMBER
) AS 
BEGIN
	insert into CHITIETPHULUC_TUYENKENH_TMP(TUYENKENH_ID,CONGTHUC_ID,SOLUONG,CUOCCONG,CUOCDAUNOI,DONGIA,GIAMGIA,THANHTIEN) VALUES(tuyenkenh_id_,congthuc_id_,soluong_,cuoccong_,cuocdaunoi_,dongia_,giamgia_,thanhtien_);
END PROC_SAVE_CTPL_TUYENKENH_TMP;

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
hopdong_id_ in varchar2
) RETURN SYS_REFCURSOR AS
l_cursor SYS_REFCURSOR;
v_vcsql VARCHAR2(2000);
v_vcsqlwhere VARCHAR2(1000);
i NUMBER;
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
	v_vcsql := 'select rownum as rn,dulieu.* from (SELECT t.*,t0.SOHOPDONG,t0.LOAIHOPDONG,t0.DOITAC_ID,t2.TENDOITAC FROM PHULUC t 
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
--  DDL for Function FIND_PHULUC_HIEULUC
--------------------------------------------------------

  CREATE OR REPLACE FUNCTION "THUEKENH"."FIND_PHULUC_HIEULUC" (
tuyenkenh_id_ in varchar2,
date_ in date
) RETURN SYS_REFCURSOR AS
l_cursor SYS_REFCURSOR;
BEGIN
	OPEN l_cursor FOR select t.* from phuluc t left join chitietphuluc_tuyenkenh t1 on t.id = t1.phuluc_id
where t1.tuyenkenh_id = tuyenkenh_id_ and ( (t.ngayhethieuluc is null and t.ngayhieuluc  <= date_ ) or (t.ngayhethieuluc is not null and t.ngayhethieuluc >= date_ and t.ngayhieuluc < date_ ) );
	RETURN l_cursor;
END FIND_PHULUC_HIEULUC;

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
soluongkenh_ in VARCHAR2
) RETURN NUMBER AS
i INTEGER := 0;
ngayhethan_ DATE := null;
BEGIN
	--select NGAYHETHAN into ngayhethan_ from HOPDONG where ID = hopdong_id_;
	if(id_ is not null) then --update
		update PHULUC set CHITIETPHULUC_ID = chitietphuluc_id_,HOPDONG_ID = hopdong_id_,TENPHULUC = tenphuluc_,LOAIPHULUC = loaiphuluc_,NGAYKY = ngayky_,NGAYHIEULUC = ngayhieuluc_,NGAYHETHIEULUC = ngayhethan_,FILENAME = filename_,FILEPATH = filepath_,FILESIZE = filesize_,CUOCDAUNOI = cuocdaunoi_,GIATRITRUOCTHUE = giatritruocthue_, GIATRISAUTHUE = giatrisauthue_, SOLUONGKENH = soluongkenh_ where ID = id_;
		i := id_;
		update PHULUC set PHULUCTHAYTHE_ID = null,NGAYHETHIEULUC = null where PHULUCTHAYTHE_ID = i;
		update CHITIETPHULUC_TUYENKENH set PHULUC_ID = null where PHULUC_ID = i;
	else --insert
		i:=SEQ_PHULUC.nextval;	
		insert into PHULUC(ID,CHITIETPHULUC_ID,HOPDONG_ID,TENPHULUC,LOAIPHULUC,NGAYKY,NGAYHIEULUC,THANG,NAM,TRANGTHAI,USERCREATE,TIMECREATE,DELETED,NGAYHETHIEULUC,FILENAME,FILEPATH,FILESIZE,PHULUCTHAYTHE_ID,CUOCDAUNOI,GIATRITRUOCTHUE,GIATRISAUTHUE,SOLUONGKENH) values (i,chitietphuluc_id_,hopdong_id_,tenphuluc_,loaiphuluc_,ngayky_,ngayhieuluc_,null,null,0,usercreate_,timecreate_,0,null,filename_,filepath_,filesize_,null,cuocdaunoi_,giatritruocthue_,giatrisauthue_,soluongkenh_);
	end if;
	update CHITIETPHULUC_TUYENKENH set PHULUC_ID = i where CHITIETPHULUC_ID = chitietphuluc_id_;
	return i;
END SAVE_PHULUC;

/

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
	v_vcsql := 'select rownum as rn,dulieu.* from (SELECT t.* FROM CHITIETPHULUC t WHERE ' || v_vcsqlwhere || ' order by t.ID desc) dulieu ';
	v_vcsql := 'SELECT * FROM (' || v_vcsql || ') WHERE rn > ' || iDisplayStart || ' and rn <= ' || (iDisplayStart+iDisplayLength);
	--dbms_output.put_line(v_vcsql);
 --test(v_vcsql);
	OPEN l_cursor FOR v_vcsql;
	RETURN l_cursor;
END FIND_CHITIETPHULUC;

/

--------------------------------------------------------
--  DDL for Function SAVE_CHITIETPHULUC
--------------------------------------------------------

  CREATE OR REPLACE FUNCTION "THUEKENH"."SAVE_CHITIETPHULUC" (
id_ in VARCHAR2,
tenchitietphuluc_ in VARCHAR2,
cuocdaunoi_ in VARCHAR2,
giatritruocthue_ in VARCHAR2,
giatrisauthue_ in VARCHAR2,
usercreate_ in VARCHAR2,
timecreate_ in VARCHAR2,
soluongkenh_ in VARCHAR2
) RETURN NUMBER AS
i INTEGER := 0;
BEGIN
	if(id_ is not null) then --update
		update CHITIETPHULUC set TENCHITIETPHULUC = tenchitietphuluc_,CUOCDAUNOI = cuocdaunoi_,GIATRITRUOCTHUE = giatritruocthue_,GIATRISAUTHUE = giatrisauthue_,SOLUONGKENH = soluongkenh_ where ID = id_;
		i := id_;
	else --insert
		i:=SEQ_CHITIETPHULUC.nextval;
		
		insert into CHITIETPHULUC(ID,TENCHITIETPHULUC,CUOCDAUNOI,GIATRITRUOCTHUE,GIATRISAUTHUE,USERCREATE,TIMECREATE,DELETED,SOLUONGKENH) values (i,tenchitietphuluc_,cuocdaunoi_,giatritruocthue_,giatrisauthue_,usercreate_,timecreate_,0,soluongkenh_);
	end if;
	insert into CHITIETPHULUC_TUYENKENH(CHITIETPHULUC_ID,TUYENKENH_ID,CONGTHUC_ID,SOLUONG,CUOCCONG,CUOCDAUNOI,DONGIA,GIAMGIA,THANHTIEN) select i,TUYENKENH_ID,CONGTHUC_ID,SOLUONG,CUOCCONG,CUOCDAUNOI,DONGIA,GIAMGIA,THANHTIEN from CHITIETPHULUC_TUYENKENH_TMP;
	return i;
END SAVE_CHITIETPHULUC;

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

