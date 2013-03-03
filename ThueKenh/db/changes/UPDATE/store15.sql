ALTER TABLE TUYENKENH 
ADD (NGAYBATDAU DATE );

ALTER TABLE TUYENKENH 
ADD (LOAIKENH NUMBER );

ALTER TABLE TUYENKENH  
MODIFY (LOAIKENH DEFAULT 0 );

CREATE TABLE SUCOKENH_BK 
(
  SUCOKENH_ID NUMBER 
, PHULUC_ID NUMBER 
, GIAMTRUMLL NUMBER 
, CREATE_TIME DATE 
, CONSTRAINT SUCOKENH_BK_PK PRIMARY KEY 
  (
    SUCOKENH_ID 
	, PHULUC_ID 
  )
  ENABLE 
);
CREATE INDEX SUCOKENH_BK_INDEX1 ON SUCOKENH_BK (SUCOKENH_ID);


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
    update TUYENKENH set NGAYBATDAU = ngayhieuluc_ where ID in (select TUYENKENH_ID from CHITIETPHULUC_TUYENKENH where CHITIETPHULUC_ID = chitietphuluc_id_);
    str := '<root><element><phuluc_id>'||i||'</phuluc_id><tenphuluc>'||tenphuluc_||'</tenphuluc></element></root>';
    for rec in (select * from CHITIETPHULUC_TUYENKENH where CHITIETPHULUC_ID = chitietphuluc_id_) loop
        PROC_INSERT_LICHSU_TUYENKENH(usercreate_,rec.TUYENKENH_ID,4,str);
    end loop;
    return i;
END SAVE_PHULUC;

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
deleted_ in VARCHAR2,
loaikenh_ in VARCHAR2
) RETURN VARCHAR2 AS
i INTEGER := 0;
madoitac varchar2(50);
matuyenkenh varchar2(20);
BEGIN
  if(id_ is not null) then --update
    update TUYENKENH set MADIEMDAU=diemdau_id_,MADIEMCUOI=diemcuoi_id_, GIAOTIEP_ID=giaotiep_id_, DUAN_ID = duan_id_,PHONGBAN_ID = phongban_id_,DOITAC_ID = doitac_id_,DUNGLUONG = dungluong_,SOLUONG = soluong_,TRANGTHAI = trangthai_,LOAIKENH = loaikenh_ where ID = id_;
    matuyenkenh := id_;
    PROC_INSERT_LICHSU_TUYENKENH(usercreate_,matuyenkenh,3,'');
  else --insert
    select ma into madoitac from doitac where id = doitac_id_;
    matuyenkenh := FN_GEN_MATUYENKENH(doitac_id_,madoitac);  
    insert into TUYENKENH(ID, MADIEMDAU, MADIEMCUOI, GIAOTIEP_ID, DUAN_ID, PHONGBAN_ID, DOITAC_ID, DUNGLUONG, SOLUONG, TRANGTHAI, USERCREATE, TIMECREATE, DELETED,LOAIKENH) values (matuyenkenh, diemdau_id_, diemcuoi_id_, giaotiep_id_, duan_id_, phongban_id_, doitac_id_, dungluong_, soluong_, trangthai_, usercreate_, timecreate_, 0,loaikenh_);
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
timecreate_ in VARCHAR2,
loaikenh_ in VARCHAR2
) RETURN NUMBER AS
i INTEGER := 0;
madoitac varchar2(50);
matuyenkenh varchar2(20);
id_tuyenkenh varchar2(50);
str varchar2(500) := '';
BEGIN
	if(tuyenkenh_id_ is not null) then --update
		update TUYENKENH set DUAN_ID = duan_id_,PHONGBAN_ID = phongban_id_,DOITAC_ID = doitac_id_,DUNGLUONG = dungluong_,SOLUONG = SOLUONG + (soluong_ - soluong_old),TRANGTHAI_BAK = TRANGTHAI, TRANGTHAI = 2, LOAIKENH = loaikenh_  where ID = tuyenkenh_id_ and DELETED = 0;
		id_tuyenkenh := tuyenkenh_id_;
    PROC_INSERT_LICHSU_TUYENKENH(usercreate_,id_tuyenkenh,3,'');
	else --insert
		i:=GET_SOTUYENKENH(doitac_id_) + 1;
    select ma into madoitac from doitac where id = doitac_id_;
    id_tuyenkenh := FN_GEN_MATUYENKENH(doitac_id_,madoitac);
		insert into TUYENKENH(ID, MADIEMDAU, MADIEMCUOI, GIAOTIEP_ID, DUAN_ID, PHONGBAN_ID, DOITAC_ID, DUNGLUONG, SOLUONG, TRANGTHAI, USERCREATE, TIMECREATE, DELETED,LOAIKENH) values (id_tuyenkenh, madiemdau_, madiemcuoi_, giaotiep_id_, duan_id_, phongban_id_, doitac_id_, dungluong_, soluong_, 1, usercreate_, timecreate_, 0,loaikenh_);
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
--  DDL for Function PARSE_UNIXTIME
--------------------------------------------------------

  CREATE OR REPLACE FUNCTION "THUEKENH"."PARSE_UNIXTIME" (
pDate date
) RETURN VARCHAR2 AS 
BEGIN
  RETURN round((pDate - to_date('01.01.1970 00:00:00','dd.mm.yyyy HH24:mi:ss')) * 24 * 60 * 60 - TO_NUMBER(SUBSTR(TZ_OFFSET(sessiontimezone),1,3))*3600);
 -- return (pDate - to_date('01.01.1970 00:00:00','dd.mm.yyyy HH24:mi:ss')) * 24 * 60 * 60 - TO_NUMBER(SUBSTR(TZ_OFFSET(sessiontimezone),1,3))*3600;
END PARSE_UNIXTIME;

/

--------------------------------------------------------
--  DDL for Function TO_MILLISECOND
--------------------------------------------------------

  CREATE OR REPLACE FUNCTION "THUEKENH"."TO_MILLISECOND" (
pDate date
) RETURN VARCHAR2 AS 
BEGIN
  RETURN round((pDate - to_date('01.01.1970 00:00:00','dd.mm.yyyy HH24:mi:ss')) * 24 * 60 * 60 - TO_NUMBER(SUBSTR(TZ_OFFSET(sessiontimezone),1,3))*3600)*1000;
 -- return (pDate - to_date('01.01.1970 00:00:00','dd.mm.yyyy HH24:mi:ss')) * 24 * 60 * 60 - TO_NUMBER(SUBSTR(TZ_OFFSET(sessiontimezone),1,3))*3600;
END TO_MILLISECOND;

/

--------------------------------------------------------
--  DDL for Procedure SUCOKENH_UPDATE_PHULUC
--------------------------------------------------------
set define off;

  CREATE OR REPLACE PROCEDURE "THUEKENH"."SUCOKENH_UPDATE_PHULUC" (
pSuCoId	in number,
pPhuLucId number,
pGiamTruMLL number,
pFlag number
) AS 
i INTEGER := 0;
BEGIN
	if(pFlag = 1) then --backup current data
		insert into sucokenh_bk(SUCOKENH_ID,PHULUC_ID,GIAMTRUMLL,CREATE_TIME) select id,phuluc_id,giamtrumll,sysdate from sucokenh where id = pSuCoId;
	end if;
	update sucokenh set PHULUC_ID = pPhuLucId,GIAMTRUMLL = pGiamTruMLL where ID = pSuCoId;
END SUCOKENH_UPDATE_PHULUC;

/

--------------------------------------------------------
--  DDL for Function FN_FIND_SUCO_FOR_TT
--------------------------------------------------------

  CREATE OR REPLACE FUNCTION "THUEKENH"."FN_FIND_SUCO_FOR_TT" 
(
  iDisplayStart IN NUMBER,   
  iDisplayLength IN NUMBER, 
  tungay_ in varchar2,
  denngay_ in varchar2,
  phulucids_ in varchar2
) 
RETURN SYS_REFCURSOR AS l_cursor SYS_REFCURSOR;
v_vcsql VARCHAR2(2000);
v_vcsqlwhere VARCHAR2(1000);
i NUMBER;
BEGIN
	v_vcsqlwhere := ' sc.DELETED = 0 ';
	if(tungay_ is not null) then
		v_vcsqlwhere := v_vcsqlwhere ||' and sc.THOIDIEMBATDAU >= '||tungay_||' ';
	end if;
	if(denngay_ is not null) then
		v_vcsqlwhere := v_vcsqlwhere ||' and sc.THOIDIEMBATDAU <= '||denngay_||' ';
	end if;
  --if(phulucids_ is not null) then
		--v_vcsqlwhere := v_vcsqlwhere ||' and sc.PHULUC_ID in ('||phulucids_||') ';
	--end if;
	v_vcsql := 'select rownum as rn,dulieu.* from (SELECT sc.id ,sc.phuluc_id,t.ID tuyenkenh_id,t.MADIEMDAU,t.MADIEMCUOI,sc.LOAISUCO,t.GIAOTIEP_ID,gt.LOAIGIAOTIEP,t.DUNGLUONG,t.SOLUONG,sc.THOIDIEMBATDAU,sc.THOIDIEMKETTHUC,
                                                        sc.THOIGIANMLL,sc.NGUYENNHAN,sc.PHUONGANXULY,sc.NGUOIXACNHAN,sc.FILENAME,sc.FILEPATH,sc.FILESIZE,sc.USERCREATE,sc.TIMECREATE,sc.BIENBANVANHANH_ID
                                                 FROM SUCOKENH sc  
                                                      LEFT JOIN TUYENKENH t ON sc.TUYENKENH_ID = t.ID 
                                                      LEFT JOIN LOAIGIAOTIEP gt ON t.GIAOTIEP_ID=gt.ID
                                                 WHERE ' || v_vcsqlwhere || ' ORDER BY sc.THOIDIEMBATDAU desc) dulieu ';
	v_vcsql := 'SELECT * FROM (' || v_vcsql || ') WHERE rn > ' || iDisplayStart || ' and rn <= ' || (iDisplayStart+iDisplayLength);
	--dbms_output.put_line(v_vcsql);
  --test(v_vcsql);
	OPEN l_cursor FOR v_vcsql;
	RETURN l_cursor;
END FN_FIND_SUCO_FOR_TT;

/

--------------------------------------------------------
--  DDL for Function FIND_SUCOBYPHULUC
--------------------------------------------------------

  CREATE OR REPLACE FUNCTION "THUEKENH"."FIND_SUCOBYPHULUC" (
pPhuLucId in varchar2
) RETURN SYS_REFCURSOR AS
l_cursor SYS_REFCURSOR;
vNgayHieuLuc date;
vNgayHetHieuLuc date;
vChiTietPhuLucId number;
BEGIN
	select NGAYHIEULUC,NGAYHETHIEULUC,CHITIETPHULUC_ID into vNgayHieuLuc,vNgayHetHieuLuc,vChiTietPhuLucId from phuluc where id = pPhuLucId;
	if(vNgayHetHieuLuc is null) then
		vNgayHetHieuLuc := SYSDATE;
	end if;
	OPEN l_cursor FOR select t.id,t.tuyenkenh_id,t.phuluc_id as suco_phuluc,t.thoidiembatdau,t.thoidiemketthuc,t.thoigianmll,t1.dongia from sucokenh t right join chitietphuluc_tuyenkenh t1 on t.tuyenkenh_id = t1.tuyenkenh_id 
where t.thoidiembatdau >= TO_MILLISECOND(vNgayHieuLuc) and t.thoidiemketthuc <= TO_MILLISECOND(vNgayHetHieuLuc) and t1.chitietphuluc_id = vChiTietPhuLucId;
	RETURN l_cursor;
END FIND_SUCOBYPHULUC;

/

--------------------------------------------------------
--  DDL for Procedure PROC_SUCO_RESET
--------------------------------------------------------
set define off;

  CREATE OR REPLACE PROCEDURE "THUEKENH"."PROC_SUCO_RESET" (
pPhuLucId in varchar2
) 
-- store nay duoc goi truoc khi edit 1 phu luc (tra lai trang thai ban dau cua tat ca su co dang thuoc phu luc edit)
AS 
vFlag number;
BEGIN
	for rec in (select * from sucokenh where DELETED = 0 and PHULUC_ID = pPhuLucId) loop
		vFlag := 1;
		for rec2 in (select * from sucokenh_bk where SUCOKENH_ID = rec.ID order by CREATE_TIME desc) loop
			update sucokenh set PHULUC_ID = rec2.PHULUC_ID,GIAMTRUMLL = rec2.GIAMTRUMLL where ID = rec.ID;
			delete sucokenh_bk where SUCOKENH_ID = rec.ID and phuluc_id = rec2.phuluc_id;
			vFlag := 0;
			exit;
		end loop;
		if(vFlag = 1) then
			update sucokenh set PHULUC_ID = null,GIAMTRUMLL = 0 where ID = rec.ID;
		end if;
	end loop;
  NULL;
END PROC_SUCO_RESET;

/

--------------------------------------------------------
--  DDL for Procedure PROC_SCHEDULE
--------------------------------------------------------
set define off;

  CREATE OR REPLACE PROCEDURE "THUEKENH"."PROC_SCHEDULE" AS 
BEGIN
  -- Kiem tra xem de xuat nao da den han ban giao nhung chua ban giao xong
  for rec in (select t.ID,t.TUYENKENH_ID from TUYENKENHDEXUAT t left join TUYENKENH t1 on t.TUYENKENH_ID=t1.ID 
where t.DELETED = 0 and t.NGAYHENBANGIAO < sysdate and t.TRANGTHAI = 0 and t.FLAG_SENDMAIL is null) loop
    SEND_SMS(rec.TUYENKENH_ID,2,null);
    SEND_EMAIL(rec.TUYENKENH_ID,2,null);
    update TUYENKENHDEXUAT set FLAG_SENDMAIL = 1 where ID = rec.ID;
  end loop;
  
  -- Cap nhat trang thai ho so thanh toan
END PROC_SCHEDULE;

/

