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
		v_vcsqlwhere := v_vcsqlwhere ||' and t0.ID like '''||replace(makenh_, '*', '%')||'%'' ';
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
doitac_ in varchar2,
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
	if(doitac_ is not null) then
		v_vcsqlwhere := v_vcsqlwhere ||' and t0.DOITAC_ID = '||doitac_||' ';
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
	v_vcsql := 'select rownum as rn,dulieu.* from (SELECT t.ID as ID,t0.ID as TUYENKENH_ID,MADIEMDAU,MADIEMCUOI,t1.LOAIGIAOTIEP,t0.DUNGLUONG,t.SOLUONG,t2.TENDUAN,t3.TENPHONGBAN,t4.TENDOITAC,t.TRANGTHAI,t.NGAYDENGHIBANGIAO,t.NGAYHENBANGIAO,t0.DOITAC_ID FROM TUYENKENHDEXUAT t left join TUYENKENH t0 on t.TUYENKENH_ID = t0.ID left join LOAIGIAOTIEP t1 on t0.GIAOTIEP_ID = t1.ID left join DUAN t2 on t0.DUAN_ID = t2.ID left join PHONGBAN t3 on t0.PHONGBAN_ID = t3.ID left join DOITAC t4 on t0.DOITAC_ID=t4.ID WHERE ' || v_vcsqlwhere || ' order by t.NGAYDENGHIBANGIAO) dulieu ';
	v_vcsql := 'SELECT * FROM (' || v_vcsql || ') WHERE rn > ' || iDisplayStart || ' and rn <= ' || (iDisplayStart+iDisplayLength);
	--dbms_output.put_line(v_vcsql);
 --test(v_vcsql);
	OPEN l_cursor FOR v_vcsql;
	RETURN l_cursor;
END FIND_TUYENKENHDEXUAT;

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
BEGIN
	if(tuyenkenh_id_ is not null) then --update
		update TUYENKENH set GIAOTIEP_ID = giaotiep_id_,DUAN_ID = duan_id_,PHONGBAN_ID = phongban_id_,DOITAC_ID = doitac_id_,DUNGLUONG = dungluong_,SOLUONG = SOLUONG + (soluong_ - soluong_old),TRANGTHAI_BAK = TRANGTHAI, TRANGTHAI = 2  where ID = tuyenkenh_id_ and DELETED = 0;
		id_tuyenkenh := tuyenkenh_id_;
	else --insert
		i:=GET_SOTUYENKENH(doitac_id_) + 1;
    select ma into madoitac from doitac where id = doitac_id_;
    id_tuyenkenh := madoitac||'_'||TRIM(to_char(i,'0009'));
		insert into TUYENKENH(ID, MADIEMDAU, MADIEMCUOI, GIAOTIEP_ID, DUAN_ID, PHONGBAN_ID, DOITAC_ID, DUNGLUONG, SOLUONG, TRANGTHAI, USERCREATE, TIMECREATE, DELETED) values (id_tuyenkenh, madiemdau_, madiemcuoi_, giaotiep_id_, duan_id_, phongban_id_, doitac_id_, dungluong_, soluong_, 1, usercreate_, timecreate_, 0);
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

