--------------------------------------------------------
--  DDL for Function FIND_HOSOTHANHTOAN
--------------------------------------------------------

  CREATE OR REPLACE FUNCTION "THUEKENH"."FIND_HOSOTHANHTOAN" (
iDisplayStart IN NUMBER,   
iDisplayLength IN NUMBER, 
sohoso_ in varchar2,
ngaychuyenhosotu_ in varchar2,
ngaychuyenhosoden_ in varchar2,
trangthai_ in varchar2
) RETURN SYS_REFCURSOR AS
l_cursor SYS_REFCURSOR;
v_vcsql VARCHAR2(2000);
v_vcsqlwhere VARCHAR2(1000);
i NUMBER;
BEGIN
	v_vcsqlwhere := ' tt.DELETED =0 ';
	if(sohoso_ is not null) then
		v_vcsqlwhere := v_vcsqlwhere ||' and tt.SOHOSO = '''||sohoso_||''' ';
	end if;
	if(ngaychuyenhosotu_ is not null) then
		v_vcsqlwhere := v_vcsqlwhere ||' and tt.NGAYCHUYENKT >= TO_DATE('''||ngaychuyenhosotu_||''',''DD-MM-RRRR'') ';
	end if;
  if(ngaychuyenhosoden_ is not null) then
		v_vcsqlwhere := v_vcsqlwhere ||' and tt.NGAYCHUYENKT <= TO_DATE('''||ngaychuyenhosoden_||''',''DD-MM-RRRR'') ';
	end if;
  if(trangthai_ is not null) then
		v_vcsqlwhere := v_vcsqlwhere ||' and tt.TRANGTHAI = '||trangthai_||' ';
	end if;
	v_vcsql := 'select rownum as rn,dulieu.* from (SELECT tt.*,dsc.tongconthanhtoan+dsc.tongconthanhtoan*10/100 giatritt,dsc.giamtrumll,extract(month from dsc.DENNGAY) as thang,extract(year from dsc.DENNGAY) as nam
                                                 FROM THANHTOAN tt INNER JOIN DOISOATCUOC dsc ON tt.DOISOATCUOC_ID=dsc.ID 
                                                 WHERE ' || v_vcsqlwhere || ' order by tt.TIMECREATE desc) dulieu ';
	v_vcsql := 'SELECT * FROM (' || v_vcsql || ') WHERE rn > ' || iDisplayStart || ' and rn <= ' || (iDisplayStart+iDisplayLength);
	dbms_output.put_line(v_vcsql);
 --test(v_vcsql);
	OPEN l_cursor FOR v_vcsql;
	RETURN l_cursor;
END FIND_HOSOTHANHTOAN;

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
trangthai_ in varchar2,
flag_ in varchar2
) RETURN SYS_REFCURSOR AS
l_cursor SYS_REFCURSOR;
v_vcsql VARCHAR2(2000);
v_vcsqlwhere VARCHAR2(1000);
i NUMBER;
BEGIN
	v_vcsqlwhere := ' t0.DELETED = 0 ';
	if(makenh_ is not null) then
		v_vcsqlwhere := v_vcsqlwhere ||' and t0.ID like '''||replace(makenh_, '*', '%')||'%'' ';
	end if;
	if(loaigiaotiep_ is not null) then
		v_vcsqlwhere := v_vcsqlwhere ||' and GIAOTIEP_ID = '||loaigiaotiep_||' ';
	end if;
	if(duan_ is not null) then
		v_vcsqlwhere := v_vcsqlwhere ||' and DUAN_ID = '||duan_||' ';
	end if;
  if(flag_ is not null) then
		v_vcsqlwhere := v_vcsqlwhere ||' and t0.FLAG = '||flag_||' ';
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
	v_vcsql := 'select rownum as rn,dulieu.* from (SELECT t0.ID,MADIEMDAU,MADIEMCUOI,t1.LOAIGIAOTIEP,t0.DUNGLUONG,t0.SOLUONG,t2.TENDUAN,t0.GIAOTIEP_ID,t0.DUAN_ID,t0.PHONGBAN_ID,t0.DOITAC_ID,t3.TENPHONGBAN,t4.TENDOITAC,t0.TRANGTHAI FROM TUYENKENH t0 left join LOAIGIAOTIEP t1 on t0.GIAOTIEP_ID = t1.ID left join DUAN t2 on t0.DUAN_ID = t2.ID left join PHONGBAN t3 on t0.PHONGBAN_ID = t3.ID left join DOITAC t4 on t0.DOITAC_ID=t4.ID WHERE ' || v_vcsqlwhere || ' order by t0.TIMECREATE desc) dulieu ';
	v_vcsql := 'SELECT * FROM (' || v_vcsql || ') WHERE rn > ' || iDisplayStart || ' and rn <= ' || (iDisplayStart+iDisplayLength);
	--dbms_output.put_line(v_vcsql);
 --test(v_vcsql);
	OPEN l_cursor FOR v_vcsql;
	RETURN l_cursor;
END FN_FIND_TUYENKENH;

/

--------------------------------------------------------
--  DDL for Function SAVE_HOPDONG
--------------------------------------------------------

  CREATE OR REPLACE FUNCTION "THUEKENH"."SAVE_HOPDONG" (
id_ in VARCHAR2,
doitac_id_ in VARCHAR2,
sohopdong_ in VARCHAR2,
loaihopdong_ in VARCHAR2,
ngayky_ in VARCHAR2,
ngayhethan_ in VARCHAR2,
usercreate_ in VARCHAR2,
timecreate_ in DATE,
history_ in VARCHAR2
) RETURN NUMBER AS
i INTEGER := 0;
BEGIN
	if(id_ is not null) then --update
		update HOPDONG set DOITAC_ID = doitac_id_,SOHOPDONG = sohopdong_,LOAIHOPDONG = loaihopdong_,NGAYKY = ngayky_,NGAYHETHAN = ngayhethan_,HISTORY = history_ where ID = id_;
		i := id_;
	else --insert
		i:=SEQ_HOPDONG.nextval;
		
		insert into HOPDONG(ID,DOITAC_ID,SOHOPDONG,LOAIHOPDONG,NGAYKY,NGAYHETHAN,TRANGTHAI,USERCREATE,TIMECREATE,HISTORY,DELETED) values (i, doitac_id_, sohopdong_, loaihopdong_, ngayky_, ngayhethan_,0, usercreate_, timecreate_, history_,0);
	end if;
	return i;
END SAVE_HOPDONG;

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
timecreate_ in DATE,
deleted_ in VARCHAR2
) RETURN VARCHAR2 AS
i INTEGER := 0;
madoitac varchar2(50);
matuyenkenh varchar2(20);
BEGIN
	if(id_ is not null) then --update
		update TUYENKENH set GIAOTIEP_ID=giaotiep_id_, DUAN_ID = duan_id_,PHONGBAN_ID = phongban_id_,DOITAC_ID = doitac_id_,DUNGLUONG = dungluong_,SOLUONG = soluong_,TRANGTHAI = trangthai_ where ID = id_;
		matuyenkenh := id_;
    PROC_INSERT_LICHSU_TUYENKENH(usercreate_,matuyenkenh,3,'');
	else --insert
    select ma into madoitac from doitac where id = doitac_id_;
		i:=GET_SOTUYENKENH(doitac_id_) + 1;
		matuyenkenh := madoitac||'_'||TRIM(to_char(i,'0009'));
		insert into TUYENKENH(ID, MADIEMDAU, MADIEMCUOI, GIAOTIEP_ID, DUAN_ID, PHONGBAN_ID, DOITAC_ID, DUNGLUONG, SOLUONG, TRANGTHAI, USERCREATE, TIMECREATE, DELETED) values (matuyenkenh, diemdau_id_, diemcuoi_id_, giaotiep_id_, duan_id_, phongban_id_, doitac_id_, dungluong_, soluong_, trangthai_, usercreate_, timecreate_, 0);
    UPDATE DOITAC SET SOTUYENKENH = SOTUYENKENH + 1 WHERE ID = doitac_id_;
    PROC_INSERT_LICHSU_TUYENKENH(usercreate_,matuyenkenh,1,'');
  end if;
	return matuyenkenh;
END SAVE_TUYENKENH;

/

