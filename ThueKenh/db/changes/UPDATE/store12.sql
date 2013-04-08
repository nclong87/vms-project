--------------------------------------------------------
--  DDL for Procedure PROC_SAVE_CONGTHUC
--------------------------------------------------------
set define off;

  CREATE OR REPLACE PROCEDURE "THUEKENH"."PROC_SAVE_CONGTHUC" (
  id_	in number,
	name_ in VARCHAR2,
  congthuc_ in VARCHAR2,
	usercreate_ in VARCHAR2,
  stt_ IN number,
  deleted_ IN number,
  ma_ in varchar2,
  isdefault_ IN number
) AS 
i INTEGER := 0;
BEGIN
    if(isdefault_ = 1) then
        update congthuc set isdefault= 0;
    end if;
    --i=0 update
      if(id_ is not null and id_>0) then --update
        update CONGTHUC set 
        TENCONGTHUC = name_,
        CHUOICONGTHUC=congthuc_,
        deleted=deleted_,
        stt=STT_,
        ma=ma_,
        isdefault=isdefault_
        where ID = id_;
    else --insert
    --i=n insert
      i:=SEQ_CONGTHUC.nextval;
      insert into CONGTHUC(ID,TENCONGTHUC,CHUOICONGTHUC,TIMECREATE,USERCREATE,STT,DELETED,MA,ISDEFAULT)
      VALUES(i,name_,congthuc_,sysdate,usercreate_,stt_,deleted_,ma_,isdefault_);
    end if;

END PROC_SAVE_CONGTHUC;

/



--------------------------------------------------------
--  DDL for Function FN_GEN_MATUYENKENH
--------------------------------------------------------

  CREATE OR REPLACE FUNCTION "THUEKENH"."FN_GEN_MATUYENKENH" (
pDoiTacId in NUMBER,
pMaDoiTac in varchar2
) RETURN VARCHAR2 AS
i NUMBER;
vFlag BOOLEAN := true;
vMaTuyenKenh VARCHAR2(50);
vNumber NUMBER;
BEGIN
	i:=GET_SOTUYENKENH(pDoitacId) + 1;
	while(vFlag) LOOP
		vMaTuyenKenh := pMaDoiTac||'_'||TRIM(to_char(i,'0009'));
		select count(*) INTO vNumber from TUYENKENH WHERE ID = vMaTuyenKenh;
		if(vNumber > 0) then
			select count(*) into i from TUYENKENH where DOITAC_ID = pDoitacId;
			update DOITAC set SOTUYENKENH = i WHERE ID = pDoitacId;
			i:=i+1;
		else
			vFlag := false;
		end if;
	END LOOP;
	RETURN vMaTuyenKenh;
END FN_GEN_MATUYENKENH;

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
		if(rec.DUPLICATE is not null) then --duplicate => update tuyenkenh
			update TUYENKENH set MADIEMDAU = rec.MADIEMDAU, MADIEMCUOI = rec.MADIEMCUOI, GIAOTIEP_ID = rec.GIAOTIEP_ID, DUAN_ID = rec.DUAN_ID, PHONGBAN_ID = rec.PHONGBAN_ID, DOITAC_ID = rec.DOITAC_ID, DUNGLUONG = rec.DUNGLUONG, SOLUONG = rec.SOLUONG, TRANGTHAI = rec.TRANGTHAI where ID = rec.DUPLICATE;
			delete from TUYENKENH_IMPORT where ID = rec.ID;
		else --insert
			matuyenkenh := FN_GEN_MATUYENKENH(rec.DOITAC_ID,rec.DOITAC_MA);  
			BEGIN
				insert into TUYENKENH(ID,MADIEMDAU,MADIEMCUOI,GIAOTIEP_ID,DUAN_ID,PHONGBAN_ID,DOITAC_ID,DUNGLUONG,TRANGTHAI,USERCREATE,TIMECREATE,DELETED,SOLUONG,TRANGTHAI_BAK) values (matuyenkenh,rec.MADIEMDAU,rec.MADIEMCUOI,rec.GIAOTIEP_ID,rec.DUAN_ID,rec.PHONGBAN_ID,rec.DOITAC_ID,rec.DUNGLUONG,rec.TRANGTHAI,usercreate_,timecreate_,0,rec.SOLUONG,0);
				UPDATE DOITAC SET SOTUYENKENH = SOTUYENKENH + 1 WHERE ID = rec.DOITAC_ID;
				delete from TUYENKENH_IMPORT where ID = rec.ID;
			EXCEPTION WHEN OTHERS THEN
				select ID into matuyenkenh from tuyenkenh where MADIEMDAU =rec.MADIEMDAU and MADIEMCUOI=rec.MADIEMCUOI and GIAOTIEP_ID=rec.GIAOTIEP_ID and DUNGLUONG=rec.DUNGLUONG;
				update TUYENKENH_IMPORT set DUPLICATE = matuyenkenh WHERE ID = rec.ID;
			END;
		end if;
	end loop;
END PROC_IMPORT_TUYENKENH;

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
    update TUYENKENH set MADIEMDAU=diemdau_id_,MADIEMCUOI=diemcuoi_id_, GIAOTIEP_ID=giaotiep_id_, DUAN_ID = duan_id_,PHONGBAN_ID = phongban_id_,DOITAC_ID = doitac_id_,DUNGLUONG = dungluong_,SOLUONG = soluong_,TRANGTHAI = trangthai_ where ID = id_;
    matuyenkenh := id_;
    PROC_INSERT_LICHSU_TUYENKENH(usercreate_,matuyenkenh,3,'');
  else --insert
    select ma into madoitac from doitac where id = doitac_id_;
    matuyenkenh := FN_GEN_MATUYENKENH(doitac_id_,madoitac);  
    insert into TUYENKENH(ID, MADIEMDAU, MADIEMCUOI, GIAOTIEP_ID, DUAN_ID, PHONGBAN_ID, DOITAC_ID, DUNGLUONG, SOLUONG, TRANGTHAI, USERCREATE, TIMECREATE, DELETED) values (matuyenkenh, diemdau_id_, diemcuoi_id_, giaotiep_id_, duan_id_, phongban_id_, doitac_id_, dungluong_, soluong_, trangthai_, usercreate_, timecreate_, 0);
    UPDATE DOITAC SET SOTUYENKENH = SOTUYENKENH + 1 WHERE ID = doitac_id_;
    PROC_INSERT_LICHSU_TUYENKENH(usercreate_,matuyenkenh,1,'');
  end if;
  return matuyenkenh;
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
str varchar2(500) := '';
BEGIN
	if(tuyenkenh_id_ is not null) then --update
		update TUYENKENH set DUAN_ID = duan_id_,PHONGBAN_ID = phongban_id_,DOITAC_ID = doitac_id_,DUNGLUONG = dungluong_,SOLUONG = SOLUONG + (soluong_ - soluong_old),TRANGTHAI_BAK = TRANGTHAI, TRANGTHAI = 2  where ID = tuyenkenh_id_ and DELETED = 0;
		id_tuyenkenh := tuyenkenh_id_;
    PROC_INSERT_LICHSU_TUYENKENH(usercreate_,id_tuyenkenh,3,'');
	else --insert
		i:=GET_SOTUYENKENH(doitac_id_) + 1;
    id_tuyenkenh := FN_GEN_MATUYENKENH(doitac_id_,madoitac);
		insert into TUYENKENH(ID, MADIEMDAU, MADIEMCUOI, GIAOTIEP_ID, DUAN_ID, PHONGBAN_ID, DOITAC_ID, DUNGLUONG, SOLUONG, TRANGTHAI, USERCREATE, TIMECREATE, DELETED) values (id_tuyenkenh, madiemdau_, madiemcuoi_, giaotiep_id_, duan_id_, phongban_id_, doitac_id_, dungluong_, soluong_, 1, usercreate_, timecreate_, 0);
		PROC_INSERT_LICHSU_TUYENKENH(usercreate_,id_tuyenkenh,1,'');
	end if;
	if(id_ is not null and id_>0) then --update
		update TUYENKENHDEXUAT set TUYENKENH_ID = id_tuyenkenh,NGAYDENGHIBANGIAO = ngaydenghibangiao_,NGAYHENBANGIAO = ngayhenbangiao_,THONGTINLIENHE = thongtinlienhe_,SOLUONG = soluong_ where ID = id_;
		i := id_;
		str := '<root><element><id>'||i||'</id></element></root>';
		PROC_INSERT_LICHSU_TUYENKENH(usercreate_,id_tuyenkenh,8,str);
	else --insert
		i:=SEQ_TUYENKENHDEXUAT.nextval;
		insert into TUYENKENHDEXUAT(ID, DEXUAT_ID, TUYENKENH_ID, BANGIAO_ID, NGAYDENGHIBANGIAO, NGAYHENBANGIAO, THONGTINLIENHE, TRANGTHAI, SOLUONG) values (i, NULL, id_tuyenkenh, NULL, ngaydenghibangiao_, ngayhenbangiao_, thongtinlienhe_, 0, soluong_);
		str := '<root><element><id>'||i||'</id></element></root>';
		PROC_INSERT_LICHSU_TUYENKENH(usercreate_,id_tuyenkenh,6,str);
	end if;
	return i;
END SAVE_TUYENKENHDEXUAT;

/
--------------------------------------------------------
--  DDL for Function TIME_BETWEEN
--------------------------------------------------------

  CREATE OR REPLACE FUNCTION "THUEKENH"."TIME_BETWEEN" (
p_from in date,
p_end in date
) RETURN varchar2 AS
l_cursor SYS_REFCURSOR;
v_year number;
v_month number;
v_day number;
v_d1 date;
v_d2 date;
BEGIN
	v_d1 := trunc(trunc(p_from, 'MM'), 'MM');
	v_d2 := LAST_DAY(p_end);
	if(p_from = v_d1 and p_end = v_d2) then
		v_month := floor(MONTHS_BETWEEN (v_d2, v_d1)) + 1;
		v_day := 0;
	elsif (p_from = v_d1) then
		v_d2 := trunc(trunc(p_end, 'MM'), 'MM');
		v_month := floor(MONTHS_BETWEEN (v_d2, v_d1));
		v_day := p_end - v_d2 + 1;
	elsif (p_end = v_d2) then
		v_d1 := LAST_DAY(p_from) + 1;
		v_month := floor(MONTHS_BETWEEN (v_d2, v_d1)) + 1;
		v_day := v_d1 - p_from;
	else
		v_d1 := LAST_DAY(p_from) + 1;
		v_d2 := trunc(trunc(p_end, 'MM'), 'MM');
    if(v_d1 > p_end) then
      v_month := 0;
      v_day := p_end - p_from + 1;
    else
      v_month := floor(MONTHS_BETWEEN (v_d2, v_d1));
      v_day := (v_d1 - p_from) + (p_end - v_d2)+1;
      --dbms_output.put_line(to_char(p_end)||to_char(v_d2));
    end if;
	end if;
	RETURN v_month||','||v_day;
END TIME_BETWEEN;

/

--------------------------------------------------------
--  DDL for Function GET_THOIGIANTHANHTOAN
--------------------------------------------------------

  CREATE OR REPLACE FUNCTION "THUEKENH"."GET_THOIGIANTHANHTOAN" (pPhuLucId IN NUMBER) RETURN VARCHAR2 AS 
vThang NUMBER;
vNam NUMBER;
BEGIN
	select THANG,NAM into vThang,vNam from PHULUC where ID = pPhuLucId;
	if(vThang is null) then
		return null;
	end if;
	return vThang||'/'||vNam;
END GET_THOIGIANTHANHTOAN; 

/

--------------------------------------------------------
--  DDL for Function FN_PHULUC_AVAILABLE
--------------------------------------------------------

  CREATE OR REPLACE FUNCTION "THUEKENH"."FN_PHULUC_AVAILABLE" (pPhuLucID IN NUMBER,pNgayDSC IN VARCHAR2) RETURN NUMBER AS 
v_num NUMBER := 0;
vNgayDSC date;
BEGIN
  vNgayDSC := to_date(pNgayDSC,'RRRR-MM-DD');
   -- select count(*) into v_num from PHULUC where DELETED = 0 and ID = pPhuLucID and NGAYHIEULUC <= to_date(pNgayDSC,'RRRR-MM-DD') and ( NGAYHETHIEULUC is null or (PHULUCTHAYTHE_ID is null and NGAYHETHIEULUC >= to_date(pNgayDSC,'RRRR-MM-DD')) or (PHULUCTHAYTHE_ID is not null and GET_THOIGIANTHANHTOAN(PHULUCTHAYTHE_ID) is null));
	select count(*) into v_num from PHULUC where DELETED = 0 and ID = pPhuLucID and NGAYHIEULUC <= LAST_DAY(vNgayDSC) 
and ( 
NGAYHETHIEULUC is null or 
(PHULUCTHAYTHE_ID is null and NGAYHETHIEULUC >= vNgayDSC) or 
(PHULUCTHAYTHE_ID is not null and GET_THOIGIANTHANHTOAN(PHULUCTHAYTHE_ID) is null)) and
(THANG is null or to_date(NAM||'-'||THANG||'-01','RRRR-MM-DD') < vNgayDSC );
  return v_num;
END FN_PHULUC_AVAILABLE;

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
	v_vcsql := 'select rownum as rn,dulieu.* from (SELECT t.*,t0.SOHOPDONG,t0.LOAIHOPDONG,t0.DOITAC_ID,t2.TENDOITAC,FIND_PHULUC_BITHAYTHE(t.ID) as PHULUCBITHAYTHE FROM PHULUC t 
		left join HOPDONG t0 on t.HOPDONG_ID = t0.ID 
		left join DOITAC t2 on t0.DOITAC_ID = t2.ID  WHERE ' || v_vcsqlwhere || ' order by t.ID desc) dulieu ';
	v_vcsql := 'SELECT * FROM (' || v_vcsql || ') WHERE rn > ' || iDisplayStart || ' and rn <= ' || (iDisplayStart+iDisplayLength);
	--dbms_output.put_line(v_vcsql);
 --test(v_vcsql);
	OPEN l_cursor FOR v_vcsql;
	RETURN l_cursor;
END FIND_PHULUC;

/



