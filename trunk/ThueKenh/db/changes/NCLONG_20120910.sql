create or replace
FUNCTION            "FN_FIND_TUYENKENH" (
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
	v_vcsqlwhere := ' 1 = 1 ';
	if(makenh_ is not null) then
		v_vcsqlwhere := v_vcsqlwhere ||' and ID = '||makenh_||' ';
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
		v_vcsqlwhere := v_vcsqlwhere ||' and diemdau.MATRAM like '''||madiemdau_||''' ';
	end if;
	if(madiemcuoi_ is not null) then
		v_vcsqlwhere := v_vcsqlwhere ||' and diemcuoi.MATRAM like '''||madiemcuoi_||''' ';
	end if;
	if(ngaydenghibangiao_ is not null) then
		v_vcsqlwhere := v_vcsqlwhere ||' and NGAYDENGHIBANGIAO = TO_DATE('''||ngaydenghibangiao_||''') ';
	end if;
	if(ngayhenbangiao_ is not null) then
		v_vcsqlwhere := v_vcsqlwhere ||' and NGAYHENBANGIAO = TO_DATE('''||ngayhenbangiao_||''') ';
	end if;
	v_vcsql := 'select rownum as rn,dulieu.* from (SELECT t0.ID,diemdau.MATRAM as MADIEMDAU,diemcuoi.MATRAM as MADIEMCUOI,t1.LOAIGIAOTIEP,t0.DUNGLUONG,t0.SOLUONG,t2.TENDUAN,t3.TENPHONGBAN,t4.TENKHUVUC,t0.TRANGTHAI FROM TUYENKENH t0 left join TRAM diemdau on t0.DIEMDAU_ID = diemdau.ID left join TRAM diemcuoi on t0.DIEMCUOI_ID = diemcuoi.ID left join LOAIGIAOTIEP t1 on t0.GIAOTIEP_ID = t1.ID left join DUAN t2 on t0.DUAN_ID = t2.ID left join PHONGBAN t3 on t0.PHONGBAN_ID = t3.ID left join KHUVUC t4 on t0.KHUVUC_ID=t4.ID WHERE ' || v_vcsqlwhere || ' order by t0.ID desc) dulieu ';
	v_vcsql := 'SELECT * FROM (' || v_vcsql || ') WHERE rn >= ' || iDisplayStart || ' and rn <= ' || (iDisplayStart+iDisplayLength);
	--dbms_output.put_line(v_vcsql);
 --test(v_vcsql);
	OPEN l_cursor FOR v_vcsql;
	RETURN l_cursor;
END FN_FIND_TUYENKENH;

create or replace
FUNCTION SAVE_TUYENKENH (
id_ in VARCHAR2,
diemdau_id_ in VARCHAR2,
diemcuoi_id_ in VARCHAR2,
giaotiep_id_ in VARCHAR2,
duan_id_ in VARCHAR2,
phongban_id_ in VARCHAR2,
khuvuc_id_ in VARCHAR2,
dungluong_ in VARCHAR2,
soluong_ in VARCHAR2,
ngaydenghibangiao_ in VARCHAR2,
ngayhenbangiao_ in VARCHAR2,
thongtinlienhe_ in VARCHAR2,
trangthai_ in VARCHAR2,
usercreate_ in VARCHAR2,
timecreate_ in VARCHAR2,
deleted_ in VARCHAR2
) RETURN NUMBER AS
i INTEGER := 0;
BEGIN
	if(id_ is not null and id_>0) then --update
		update TUYENKENH set DIEMDAU_ID = diemdau_id_,DIEMCUOI_ID = diemcuoi_id_,GIAOTIEP_ID = giaotiep_id_,DUAN_ID = duan_id_,PHONGBAN_ID = phongban_id_,KHUVUC_ID = khuvuc_id_,DUNGLUONG = dungluong_,SOLUONG = soluong_,NGAYDENGHIBANGIAO = ngaydenghibangiao_,NGAYHENBANGIAO = ngayhenbangiao_,THONGTINLIENHE = thongtinlienhe_,TRANGTHAI = trangthai_ where ID = id_;
		i := id_;
	else --insert
		i:=SEQ_TUYENKENH.nextval;
		
		insert into TUYENKENH(ID, DIEMDAU_ID, DIEMCUOI_ID, GIAOTIEP_ID, DUAN_ID, PHONGBAN_ID, KHUVUC_ID, DUNGLUONG, SOLUONG, NGAYDENGHIBANGIAO, NGAYHENBANGIAO, THONGTINLIENHE, TRANGTHAI, USERCREATE, TIMECREATE, DELETED) values (i, diemdau_id_, diemcuoi_id_, giaotiep_id_, duan_id_, phongban_id_, khuvuc_id_, dungluong_, soluong_, ngaydenghibangiao_, ngayhenbangiao_, thongtinlienhe_, -1, usercreate_, timecreate_, 0);
	end if;
	return i;
END SAVE_TUYENKENH;

CREATE SEQUENCE "THUEKENH"."SEQ_TUYENKENH" MINVALUE 1 MAXVALUE 99999 INCREMENT BY 1 START WITH 21 CACHE 20 NOORDER NOCYCLE ;

