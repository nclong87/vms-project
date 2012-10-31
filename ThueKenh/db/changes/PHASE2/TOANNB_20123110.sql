CREATE SEQUENCE SEQ_CHITIETPHULUC INCREMENT BY 1 START WITH 1 MAXVALUE 99999 MINVALUE 1;

ALTER TABLE CHITIETPHULUC  
MODIFY (DELETED NUMBER );

ALTER TABLE CHITIETPHULUC
ADD CONSTRAINT CHITIETPHULUC_UK1 UNIQUE 
(
  TENCHITIETPHULUC 
, DELETED 
)
ENABLE;

--------------------------------------------------------
--  DDL for Function FIND_PHULUC
--------------------------------------------------------

  CREATE OR REPLACE FUNCTION "THUEKENH"."FIND_PHULUC" (
iDisplayStart IN NUMBER,   
iDisplayLength IN NUMBER, 
tenhopdong_ in varchar2,
tenphuluc_ in varchar2,
loaiphuluc_ in varchar2,
ngayky_ in varchar2,
ngayhieuluc_ in varchar2,
hopdong_id_ in varchar2
) RETURN SYS_REFCURSOR AS
l_cursor SYS_REFCURSOR;
v_vcsql VARCHAR2(2000);
v_vcsqlwhere VARCHAR2(1000);
i NUMBER;
BEGIN
	v_vcsqlwhere := ' t.DELETED = 0 ';
	if(tenhopdong_ is not null) then
		v_vcsqlwhere := v_vcsqlwhere ||' and t0.SOHOPDONG like ''%'||tenhopdong_||'%'' ';
	end if;
	if(tenphuluc_ is not null) then
		v_vcsqlwhere := v_vcsqlwhere ||' and t.TENPHULUC like ''%'||tenphuluc_||'%'' ';
	end if;
	if(loaiphuluc_ is not null) then
		v_vcsqlwhere := v_vcsqlwhere ||' and t.LOAIPHULUC = '||loaiphuluc_||' ';
	end if;
	if(ngayky_ is not null) then
		v_vcsqlwhere := v_vcsqlwhere ||' and t.NGAYKY = TO_DATE('''||ngayky_||''',''DD-MM-RRRR'') ';
	end if;
	if(ngayhieuluc_ is not null) then
		v_vcsqlwhere := v_vcsqlwhere ||' and t.NGAYHIEULUC = TO_DATE('''||ngayhieuluc_||''',''DD-MM-RRRR'') ';
	end if;
  if(hopdong_id_ is not null) then
		v_vcsqlwhere := v_vcsqlwhere ||' and t.HOPDONG_ID = '||hopdong_id_||' ';
	end if;
	v_vcsql := 'select rownum as rn,dulieu.* from (SELECT t.*,t0.LOAIHOPDONG,t0.DOITAC_ID,t2.TENDOITAC,t1.CUOCDAUNOI,t1.GIATRITRUOCTHUE,t1.GIATRISAUTHUE,t1.SOLUONGKENH FROM PHULUC t 
		left join HOPDONG t0 on t.HOPDONG_ID = t0.ID 
		left join CHITIETPHULUC t1 on t.CHITIETPHULUC_ID = t1.ID 
		left join DOITAC t2 on t0.DOITAC_ID = t2.ID  WHERE ' || v_vcsqlwhere || ' order by t.ID desc) dulieu ';
	v_vcsql := 'SELECT * FROM (' || v_vcsql || ') WHERE rn > ' || iDisplayStart || ' and rn <= ' || (iDisplayStart+iDisplayLength);
	--dbms_output.put_line(v_vcsql);
 --test(v_vcsql);
	OPEN l_cursor FOR v_vcsql;
	RETURN l_cursor;
END FIND_PHULUC;

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

