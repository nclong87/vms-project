ALTER TABLE BANGIAO 
DROP COLUMN FILESCAN_ID;

ALTER TABLE BANGIAO 
ADD (FILENAME VARCHAR2(200) );

ALTER TABLE BANGIAO 
ADD (FILEPATH VARCHAR2(200) );

ALTER TABLE BANGIAO 
ADD (FILESIZE VARCHAR2(20) );

CREATE SEQUENCE SEQ_BANGIAO INCREMENT BY 1 START WITH 1 MAXVALUE 9999 MINVALUE 1;

ALTER TABLE TUYENKENHDEXUAT 
ADD (TIENDO NUMBER DEFAULT 0 );

drop table "THUEKENH"."HOCSINH"  ;
drop table "THUEKENH"."FILESCAN" cascade constraints ;

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
--  DDL for Procedure PROC_SAFEFIND
--------------------------------------------------------
set define off;

  CREATE OR REPLACE PROCEDURE "THUEKENH"."PROC_SAFEFIND" (
vc_sql in CLOB,
diemdau_id_ out TUYENKENH%rowtype)
AS 
BEGIN
  NULL;
END PROC_SAFEFIND;

/

--------------------------------------------------------
--  DDL for Procedure PROC_SAVE_ACCOUNTMENU
--------------------------------------------------------
set define off;

  CREATE OR REPLACE PROCEDURE "THUEKENH"."PROC_SAVE_ACCOUNTMENU" (
pi_array in TABLE_VARCHAR,
pi_id in VARCHAR2
) AS 
i INTEGER := 1;
BEGIN
	delete from USER_MENU where ACCOUNTID = pi_id;
  if(pi_array.COUNT() = 0 ) then 
    return;
  end if;
	LOOP
		INSERT  INTO USER_MENU (ACCOUNTID,MENUID) VALUES(pi_id,pi_array(i));
		EXIT WHEN(i = pi_array.COUNT());
		i := i + 1;
	END LOOP;
END PROC_SAVE_ACCOUNTMENU;

/

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
  ma_ in varchar2
) AS 
i INTEGER := 0;
BEGIN
    --i=0 update
      if(id_ is not null and id_>0) then --update
        update CONGTHUC set 
        TENCONGTHUC = name_,
        CHUOICONGTHUC=congthuc_,
        deleted=deleted_,
        stt=STT_,
        ma=ma_
        where ID = id_;
    else --insert
    --i=n insert
      i:=SEQ_CONGTHUC.nextval;
      insert into CONGTHUC(ID,TENCONGTHUC,CHUOICONGTHUC,TIMECREATE,USERCREATE,STT,DELETED,MA)
      VALUES(i,name_,congthuc_,sysdate,usercreate_,stt_,deleted_,ma_);
    end if;

END PROC_SAVE_CONGTHUC;

/

--------------------------------------------------------
--  DDL for Procedure PROC_SAVE_DOITAC
--------------------------------------------------------
set define off;

  CREATE OR REPLACE PROCEDURE "THUEKENH"."PROC_SAVE_DOITAC" (
  id_	in nvarchar2,
	name_ in VARCHAR2,
	stt_ IN number,
  deleted_ IN number,
  ma_ in nvarchar2
) AS 
i INTEGER := 0;
BEGIN
		if(id_ is not null and id_>0) then --update
      update DOITAC set TENDOITAC = name_,Ma=ma_ where ID = id_;
	else --insert
		i:=SEQ_DOITAC.nextval;
		insert into DOITAC(ID,TENDOITAC,DELETED,STT,MA) values (i,name_,deleted_,stt_,ma_);
  end if;
END PROC_SAVE_DOITAC;

/

--------------------------------------------------------
--  DDL for Procedure PROC_SAVE_DUAN
--------------------------------------------------------
set define off;

  CREATE OR REPLACE PROCEDURE "THUEKENH"."PROC_SAVE_DUAN" (
  id_	in nvarchar2,
	name_ in VARCHAR2,
	stt_ IN number,
  deleted_ IN number,
  mota_ in nvarchar2,
  giamgia_ in number,
  usercreate_ in varchar2,
  ma_ in varchar2
) AS 
i INTEGER := 0;
BEGIN
		i:=SEQ_DUAN.nextval;
		insert into DUAN(ID,TENDUAN,DELETED,STT,MOTA,GIAMGIA,USERCREATE,TIMECREATE,MA) values (i,name_,deleted_,stt_,mota_,giamgia_,usercreate_,sysdate,ma_);
END PROC_SAVE_DUAN;

/

--------------------------------------------------------
--  DDL for Procedure PROC_SAVE_GROUPMENU
--------------------------------------------------------
set define off;

  CREATE OR REPLACE PROCEDURE "THUEKENH"."PROC_SAVE_GROUPMENU" (
pi_array in TABLE_VARCHAR,
pi_id in VARCHAR2
) AS 
i INTEGER := 1;
BEGIN
	delete from GROUP_MENU where IDGROUP = pi_id;
  if(pi_array.COUNT() = 0 ) then 
    return;
  end if;
	LOOP
		INSERT  INTO GROUP_MENU (IDGROUP,IDMENU) VALUES(pi_id,pi_array(i));
		EXIT WHEN(i = pi_array.COUNT());
		i := i + 1;
	END LOOP;
END PROC_SAVE_GROUPMENU;

/

--------------------------------------------------------
--  DDL for Procedure PROC_SAVE_KHUVUC
--------------------------------------------------------
set define off;

  CREATE OR REPLACE PROCEDURE "THUEKENH"."PROC_SAVE_KHUVUC" (
  id_	in nvarchar2,
	name_ in VARCHAR2,
	stt_ IN number,
  deleted_ IN number,
  ma_ in varchar2
) AS 
i INTEGER := 0;
BEGIN
		if(id_ is not null and id_>0) then --update
      update KHUVUC set TENKHUVUC = name_ where ID = id_;
	else --insert
		i:=SEQ_PHONGBAN.nextval;
		insert into KHUVUC(ID,TENKHUVUC,DELETED,STT,MA) values (i,name_,deleted_,stt_,ma_);
  end if;
END PROC_SAVE_KHUVUC;

/

--------------------------------------------------------
--  DDL for Procedure PROC_SAVE_LOAIGIAOTIEP
--------------------------------------------------------
set define off;

  CREATE OR REPLACE PROCEDURE "THUEKENH"."PROC_SAVE_LOAIGIAOTIEP" (
  id_	in number,
	name_ in VARCHAR2,
	cuoccong_ IN number,
  deleted_ IN number,
  ma_ in varchar2,
  stt_ in number
) AS 
i INTEGER := 0;
BEGIN

    --i=0 update
      if(id_ is not null and id_>0) then --update
        update LOAIGIAOTIEP set LOAIGIAOTIEP = name_,CUOCCONG=cuoccong_,Ma=ma_,STT=stt_ where ID = id_;
    else --insert
    --i=n insert
      i:=SEQ_LOAIGIAOTIEP.nextval;
      insert into LOAIGIAOTIEP(ID,LOAIGIAOTIEP,DELETED,CUOCCONG,MA,STT) values (i,name_,deleted_,cuoccong_,ma_,stt_);
    end if;

END PROC_SAVE_LOAIGIAOTIEP;

/

--------------------------------------------------------
--  DDL for Procedure PROC_SAVE_PHONGBAN
--------------------------------------------------------
set define off;

  CREATE OR REPLACE PROCEDURE "THUEKENH"."PROC_SAVE_PHONGBAN" (
  id_	in nvarchar2,
	name_ in VARCHAR2,
	stt_ IN number,
  deleted_ IN number,
  ma_ in VARCHAR2
) AS 
i INTEGER := 0;
BEGIN
		i:=SEQ_PHONGBAN.nextval;
		insert into PHONGBAN(ID,TENPHONGBAN,DELETED,STT,MA) values (i,name_,deleted_,stt_,ma_);
END PROC_SAVE_PHONGBAN;

/

--------------------------------------------------------
--  DDL for Procedure PROC_SAVE_TIEUCHUAN
--------------------------------------------------------
set define off;

  CREATE OR REPLACE PROCEDURE "THUEKENH"."PROC_SAVE_TIEUCHUAN" (
id_ in varchar2,
tentieuchuan_ in varchar2,
loaitieuchuan_ in number,
mota_ in varchar2,
usercreate_ in varchar2,
stt_ in number,
deleted_ in number,
ma_ in varchar2
) AS 
i INTEGER := 0;
BEGIN
    --i=n insert
      i:=SEQ_TIEUCHUAN.nextval;
      insert into TIEUCHUAN(id,tentieuchuan,loaitieuchuan,mota,usercreate,timecreate,stt,deleted,ma) 
      values (i,tentieuchuan_,loaitieuchuan_,mota_,usercreate_,sysdate,stt_,deleted_,ma_);

END PROC_SAVE_TIEUCHUAN;

/

--------------------------------------------------------
--  DDL for Procedure PROC_UPDATE_TIEN_DO
--------------------------------------------------------
set define off;

  CREATE OR REPLACE PROCEDURE "THUEKENH"."PROC_UPDATE_TIEN_DO" (
tuyenkenh_dexuat_id in number,
arr_tieuchuan_id in TABLE_VARCHAR,
username_ in varchar2,
createtime_ in varchar2
)
AS
iCount number := 0;
tong_tieu_chuan number := 0;
chua_dat number := 0;
iDexuat number;
tiendo_ number;
iTuyenKenhDeXuatChuaBanGiao number;
i number;
begin
	DELETE from TUYENKENH_TIEUCHUAN where TUYENKENHDEXUAT_ID = tuyenkenh_dexuat_id;
  if(arr_tieuchuan_id.count() > 0) then
    for i in arr_tieuchuan_id.first .. arr_tieuchuan_id.last loop
        INSERT INTO TUYENKENH_TIEUCHUAN (TUYENKENHDEXUAT_ID, TIEUCHUAN_ID, USERCREATE, TIMECREATE, DELETED) 
        VALUES (tuyenkenh_dexuat_id, arr_tieuchuan_id(i), username_, createtime_, '0');
        iCount := iCount + 1;
    end loop;
  end if;
	select count(*) into tong_tieu_chuan  from tieuchuan where deleted=0;
	select count(*) into chua_dat  from tieuchuan where deleted=0 and loaitieuchuan = 1 and id not in (select * from table(arr_tieuchuan_id));
	if(chua_dat = 0) then
		update tuyenkenhdexuat set TIENDO = 100,trangthai=1 where id=tuyenkenh_dexuat_id;
		select dexuat_id into iDexuat from tuyenkenhdexuat where id=tuyenkenh_dexuat_id and deleted=0;
		if(iDexuat is not null) then
			select count(*) into iTuyenKenhDeXuatChuaBanGiao  from tuyenkenhdexuat where dexuat_id=iDexuat and trangthai!=1 and  deleted=0;
			if(iTuyenKenhDeXuatChuaBanGiao = 0) then
				update dexuat set trangthai=1 where id=iDexuat;
			end if;
		end if;
	else
		if(tong_tieu_chuan = 0) then
			tiendo_ := 0;
		else
			tiendo_ := round(iCount/tong_tieu_chuan*100,2);
		end if;
		update tuyenkenhdexuat set TIENDO = tiendo_ where id=tuyenkenh_dexuat_id;
	end if;
end PROC_UPDATE_TIEN_DO;

/

--------------------------------------------------------
--  DDL for Procedure RESET_SEQ
--------------------------------------------------------
set define off;

  CREATE OR REPLACE PROCEDURE "THUEKENH"."RESET_SEQ" ( p_seq_name in varchar2 )
is
    l_val number;
begin
    execute immediate
    'select ' || p_seq_name || '.nextval from dual' INTO l_val;

    execute immediate
    'alter sequence ' || p_seq_name || ' increment by -' || l_val || 
                                                          ' minvalue 0';

    execute immediate
    'select ' || p_seq_name || '.nextval from dual' INTO l_val;

    execute immediate
    'alter sequence ' || p_seq_name || ' increment by 1 minvalue 0';
end;

/

--------------------------------------------------------
--  DDL for Procedure SAVE_SUCO_IMPORT
--------------------------------------------------------
set define off;

  CREATE OR REPLACE PROCEDURE "THUEKENH"."SAVE_SUCO_IMPORT" (
stt_ in NUMBER,
madiemdau_ in VARCHAR2,
madiemcuoi_ in VARCHAR2,
magiaotiep_ in VARCHAR2,
thoidiembatdau_ in NUMBER,
thoidiemketthuc_ in NUMBER,
nguyennhan_ in VARCHAR2,
phuonganxuly_ in VARCHAR2,
nguoixacnhan_ in VARCHAR2,
tuyenkenh_id_ in VARCHAR2,
phuluc_id_ in VARCHAR2,
thoigianmll_ in VARCHAR2,
giamtrumll_ in VARCHAR2
) AS
i INTEGER := 0;
BEGIN
    i:=SEQ_SUCOIMPORT.nextval;
    --test(to_char(thoidiembatdau_,'DD-MON-YYYY HH24:MI'));
    insert into SUCO_IMPORT(STT,MADIEMDAU,MADIEMCUOI,MAGIAOTIEP,THOIDIEMBATDAU,THOIDIEMKETTHUC,NGUYENNHAN,PHUONGANXULY,NGUOIXACNHAN,ID,TUYENKENH_ID,PHULUC_ID,THOIGIANMLL,GIAMTRUMLL) 
    values (stt_,madiemdau_,madiemcuoi_,magiaotiep_,thoidiembatdau_,thoidiemketthuc_,nguyennhan_,phuonganxuly_,nguoixacnhan_,i,tuyenkenh_id_,phuluc_id_,thoigianmll_,giamtrumll_);
END SAVE_SUCO_IMPORT;

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
--  DDL for Function CAPNHATTIENDO
--------------------------------------------------------

  CREATE OR REPLACE FUNCTION "THUEKENH"."CAPNHATTIENDO" 
(
tuyenkenh_tieuchuan_id_ in varchar2,
tieuchuan_id_ in varchar2,
username_ in varchar2
)
return number as 
iCount number:=0;
begin
  select count(*) into iCount from TUYENKENH_TIEUCHUAN where TUYENKENHDEXUAT_ID=tuyenkenh_tieuchuan_id_ and TIEUCHUAN_ID=tieuchuan_id_;
  if ( iCount = 0) then

    INSERT INTO TUYENKENH_TIEUCHUAN (TUYENKENHDEXUAT_ID, TIEUCHUAN_ID, USERCREATE, TIMECREATE, DELETED) 
    VALUES (tuyenkenh_tieuchuan_id_, tieuchuan_id_, username_, sysdate, '0');

    else

    update TUYENKENH_TIEUCHUAN set deleted=0 
    where TUYENKENHDEXUAT_ID=tuyenkenh_tieuchuan_id_ and TIEUCHUAN_ID=tieuchuan_id_ and deleted=1;
    
end if;
  return null;
end capnhattiendo;

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
	v_vcsql := 'select rownum as rn,dulieu.* from (SELECT t.ID,t.STT, t.MADIEMDAU, t.MADIEMCUOI, t.MAGIAOTIEP, t.THOIDIEMBATDAU, t.THOIDIEMKETTHUC, t.NGUYENNHAN, t.PHUONGANXULY, t.TUYENKENH_ID,t.NGUOIXACNHAN,t0.LOAIGIAOTIEP FROM SUCO_IMPORT t left join LOAIGIAOTIEP t0 on t.MAGIAOTIEP = t0.MA  order by t.STT) dulieu ';
	v_vcsql := 'SELECT * FROM (' || v_vcsql || ') WHERE rn > ' || iDisplayStart || ' and rn <= ' || (iDisplayStart+iDisplayLength);
	--dbms_output.put_line(v_vcsql);
 --test(v_vcsql);
	OPEN l_cursor FOR v_vcsql;
	RETURN l_cursor;
END FIND_SUCOIMPORT;

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
--  DDL for Function FN_FIND_BIENBANVANHANHKENH
--------------------------------------------------------

  CREATE OR REPLACE FUNCTION "THUEKENH"."FN_FIND_BIENBANVANHANHKENH" 
(
  iDisplayStart IN NUMBER,   
  iDisplayLength IN NUMBER, 
  sobienban_ in varchar2
) 
RETURN SYS_REFCURSOR AS l_cursor SYS_REFCURSOR;
v_vcsql VARCHAR2(2000);
v_vcsqlwhere VARCHAR2(1000);
i NUMBER;
BEGIN
	v_vcsqlwhere := ' DELETED = 0 ';
	if(sobienban_ is not null) then
		v_vcsqlwhere := v_vcsqlwhere ||' AND SOBIENBAN = '''||sobienban_||''' ';
	end if;
	v_vcsql := 'select rownum as rn,dulieu.* from (SELECT *
                                                 FROM BIENBANVANHANH   
                                                 WHERE ' || v_vcsqlwhere || ' ORDER BY TIMECREATE desc) dulieu ';
	v_vcsql := 'SELECT * FROM (' || v_vcsql || ') WHERE rn > ' || iDisplayStart || ' and rn <= ' || (iDisplayStart+iDisplayLength);
	--dbms_output.put_line(v_vcsql);
  --test(v_vcsql);
	OPEN l_cursor FOR v_vcsql;
	RETURN l_cursor;
END FN_FIND_BIENBANVANHANHKENH;

/

--------------------------------------------------------
--  DDL for Function FN_FIND_SUCO
--------------------------------------------------------

  CREATE OR REPLACE FUNCTION "THUEKENH"."FN_FIND_SUCO" 
(
  iDisplayStart IN NUMBER,   
  iDisplayLength IN NUMBER, 
  tuyenkenh_id_ in varchar2,
  diemdau_ in varchar2,
  diemcuoi_ in varchar2,
  dungluong_ in varchar2,
  thoidiembatdautu_ in varchar2,
  thoidiembatdauden_ in varchar2,
  thoidiemketthuctu_ in varchar2,
  thoidiemketthucden_ in varchar2,
  nguoixacnhan_ in varchar2,
  bienbanvanhanh_id_ in varchar2
) 
RETURN SYS_REFCURSOR AS l_cursor SYS_REFCURSOR;
v_vcsql VARCHAR2(2000);
v_vcsqlwhere VARCHAR2(1000);
i NUMBER;
BEGIN
	v_vcsqlwhere := ' sc.DELETED = 0 ';
	if(tuyenkenh_id_ is not null) then
		v_vcsqlwhere := v_vcsqlwhere ||' AND sc.TUYENKENH_ID = '||tuyenkenh_id_||' ';
	end if;
  dbms_output.put_line(diemdau_);
	if(diemdau_ is not null) then
		v_vcsqlwhere := v_vcsqlwhere ||' AND t.MADIEMDAU = '''||diemdau_||''' ';
	end if;
	if(diemcuoi_ is not null) then
		v_vcsqlwhere := v_vcsqlwhere ||' AND t.MADIEMCUOI = '''||diemcuoi_||''' ';
	end if;
	if(dungluong_ is not null) then
		v_vcsqlwhere := v_vcsqlwhere ||' and t.DUNGLUONG = '||dungluong_ ||' ';
	end if;
	if(thoidiembatdautu_ is not null) then
		v_vcsqlwhere := v_vcsqlwhere ||' and sc.THOIDIEMBATDAU >= '||thoidiembatdautu_||' ';
	end if;
	if(thoidiembatdauden_ is not null) then
		v_vcsqlwhere := v_vcsqlwhere ||' and sc.THOIDIEMBATDAU <= '||thoidiembatdauden_||' ';
	end if;
  if(thoidiemketthuctu_ is not null) then
		v_vcsqlwhere := v_vcsqlwhere ||' and sc.THOIDIEMKETTHUC >= '||thoidiemketthuctu_||' ';
	end if;
	if(thoidiemketthucden_ is not null) then
		v_vcsqlwhere := v_vcsqlwhere ||' and sc.THOIDIEMKETTHUC <= '||thoidiemketthucden_||' ';
	end if;
	if(nguoixacnhan_ is not null) then
		v_vcsqlwhere := v_vcsqlwhere ||' and sc.NGUOIXACNHAN like ''%'||replace(nguoixacnhan_, '*', '%')||'%'' ';
	end if;
  if(bienbanvanhanh_id_ is not null) then
		v_vcsqlwhere := v_vcsqlwhere ||' and sc.BIENBANVANHANH_ID='||bienbanvanhanh_id_||' ';
	end if;
	v_vcsql := 'select rownum as rn,dulieu.* from (SELECT sc.id suco_id,t.ID tuyenkenh_id,t.MADIEMDAU,t.MADIEMCUOI,gt.LOAIGIAOTIEP,t.DUNGLUONG,t.SOLUONG,sc.THOIDIEMBATDAU,sc.THOIDIEMKETTHUC,
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
END FN_FIND_SUCO;

/

--------------------------------------------------------
--  DDL for Function FN_FIND_SUCO_BY_BIENBANVANHANH
--------------------------------------------------------

  CREATE OR REPLACE FUNCTION "THUEKENH"."FN_FIND_SUCO_BY_BIENBANVANHANH" 
(
  bienbanvanhanh_id_ in varchar2
) 
RETURN SYS_REFCURSOR AS l_cursor SYS_REFCURSOR;
v_vcsql VARCHAR2(2000);
v_vcsqlwhere VARCHAR2(1000);
i NUMBER;
BEGIN
	v_vcsqlwhere := ' DELETED = 0 ';
  if(bienbanvanhanh_id_ is not null) then
		v_vcsqlwhere := v_vcsqlwhere ||' and BIENBANVANHANH_ID='||bienbanvanhanh_id_||' ';
	end if;
	v_vcsql := 'select rownum as rn,dulieu.* from (SELECT *
                                                 FROM SUCOKENH 
                                                 WHERE ' || v_vcsqlwhere || ') dulieu ';
	v_vcsql := 'SELECT * FROM (' || v_vcsql || ')';
	--dbms_output.put_line(v_vcsql);
  --test(v_vcsql);
	OPEN l_cursor FOR v_vcsql;
	RETURN l_cursor;
END FN_FIND_SUCO_BY_BIENBANVANHANH;

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
--  DDL for Function FN_TEST
--------------------------------------------------------

  CREATE OR REPLACE FUNCTION "THUEKENH"."FN_TEST" (dungluong_ varchar2) RETURN VARCHAR2 AS 
type r_cursor is REF CURSOR;
  c_emp r_cursor;
  er TUYENKENH%rowtype;
BEGIN
  dbms_output.put_line('ssss');
  open c_emp for select * into er from tuyenkenh where id=12;
  fetch c_emp into er;
  if(c_emp%notfound = false) then 
    dbms_output.put_line(er.DUNGLUONG || ' - ' || er.SOLUONG);
    if(er.DUNGLUONG!=dungluong_) then
      dbms_output.put_line('change');
    end if;
     
  end if;
  close c_emp;
  RETURN NULL;
END FN_TEST;

/

--------------------------------------------------------
--  DDL for Function GET_MENU_BY_ACCOUNT
--------------------------------------------------------

  CREATE OR REPLACE FUNCTION "THUEKENH"."GET_MENU_BY_ACCOUNT" (
account_id in varchar2
) RETURN SYS_REFCURSOR AS
l_cursor SYS_REFCURSOR;
i NUMBER;
BEGIN
	OPEN l_cursor FOR select t1.* from USER_MENU t0 left join MENU t1 on t0.MENUID = t1.ID where ACCOUNTID = account_id;
	RETURN l_cursor;
END GET_MENU_BY_ACCOUNT;

/

--------------------------------------------------------
--  DDL for Function GET_MENU_BY_GROUP
--------------------------------------------------------

  CREATE OR REPLACE FUNCTION "THUEKENH"."GET_MENU_BY_GROUP" (
groupid_ in varchar2
) RETURN SYS_REFCURSOR AS
l_cursor SYS_REFCURSOR;
i NUMBER;
BEGIN
	OPEN l_cursor FOR select t1.* from GROUP_MENU t0 left join MENU t1 on t0.IDMENU = t1.ID where IDGROUP = groupid_;
	RETURN l_cursor;
END GET_MENU_BY_GROUP;

/

--------------------------------------------------------
--  DDL for Function GET_TIENDO
--------------------------------------------------------

  CREATE OR REPLACE FUNCTION "THUEKENH"."GET_TIENDO" (
tuyenkenh_dexuat_id in number
)
return integer is PRAGMA AUTONOMOUS_TRANSACTION;
t1 NUMBER ;
t2 number;
iCount number;
iFinish number;
iDexuat number;
begin
  select count(*) into t1  from tuyenkenh_tieuchuan tt,tieuchuan tc where tt.tieuchuan_id=tc.id and tc.loaitieuchuan=1 and tuyenkenhdexuat_id=tuyenkenh_dexuat_id and tt.deleted=0 and tc.deleted=0;
  select count(*) into t2  from tieuchuan where loaitieuchuan=1 and deleted=0;
  t1:=t1/t2;
  if t1=1 then
    update tuyenkenhdexuat set trangthai=1 where id=tuyenkenh_dexuat_id;
    COMMIT;
    select dexuat_id into iDexuat from tuyenkenhdexuat where id=tuyenkenh_dexuat_id and deleted=0;
    select count(*) into iCount from tuyenkenhdexuat where  dexuat_id=iDexuat and  deleted=0;
    select count(*) into iFinish  from tuyenkenhdexuat where dexuat_id=iDexuat and trangthai=1 and  deleted=0;
    if iCount = iFinish then
      update dexuat set trangthai=1 where id=iDexuat;
      COMMIT;
    end if;
  end if;
  return t1*100;
end get_tiendo;

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
--  DDL for Function SAVE_BANGIAO
--------------------------------------------------------

  CREATE OR REPLACE FUNCTION "THUEKENH"."SAVE_BANGIAO" (
id_ in VARCHAR2,
sobienban_ in VARCHAR2,
usercreate_ in VARCHAR2,
timecreate_ in VARCHAR2,
filename_ in VARCHAR2,
filepath_ in VARCHAR2,
filesize_ in VARCHAR2
) RETURN NUMBER AS
i INTEGER := 0;
BEGIN
	if(id_ is not null and id_>0) then --update
		update BANGIAO set SOBIENBAN = sobienban_,FILENAME = filename_,FILEPATH = filepath_,FILESIZE = filesize_ where ID = id_;
		i := id_;
    update TUYENKENHDEXUAT set BANGIAO_ID = null,TRANGTHAI = 1 where BANGIAO_ID = id_;
	else --insert
		i:=SEQ_BANGIAO.nextval;
		
		insert into BANGIAO(ID,SOBIENBAN,USERCREATE,TIMECREATE,DELETED,FILENAME,FILEPATH,FILESIZE) values (i,sobienban_,usercreate_,timecreate_,0,filename_,filepath_,filesize_);
	end if;
	return i;
END SAVE_BANGIAO;

/

--------------------------------------------------------
--  DDL for Function SAVE_BIENBANVANHANH
--------------------------------------------------------

  CREATE OR REPLACE FUNCTION "THUEKENH"."SAVE_BIENBANVANHANH" 
(
  id_ in varchar2,
  sobienban_ in varchar2,
  usercreate_ in varchar2,
  timecreate_ in varchar2,
  deleted_ in varchar2,
  filename_ in varchar2,
  filepath_ in varchar2,
  filesize_ in varchar2
)
RETURN NUMBER AS i INTEGER :=0; 
BEGIN
  IF(id_ IS NOT NULL AND id_ >0) THEN --update
    UPDATE BIENBANVANHANH 
    SET 
        SOBIENBAN= sobienban_, 
        DELETED= deleted_,
        FILENAME= filename_,
        FILEPATH= filepath_,
        FILESIZE= filesize_
    WHERE ID= id_;
    i:= id_;
  ELSE -- insert
    i:=SEQ_BIENBANVANHANH.nextval;
    INSERT INTO BIENBANVANHANH(ID,SOBIENBAN,USERCREATE,TIMECREATE,DELETED,FILENAME,FILEPATH,FILESIZE) VALUES (i,sobienban_, usercreate_, timecreate_, 0,filename_, filepath_, filesize_);
  END IF;
  RETURN i;
END SAVE_BIENBANVANHANH;

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
--  DDL for Function SAVE_SUCOKENH
--------------------------------------------------------

  CREATE OR REPLACE FUNCTION "THUEKENH"."SAVE_SUCOKENH" 
(
  id_ in varchar2,
  tuyenkenh_id_ in varchar2,
  phuluc_id_ in varchar2,
  thanhtoan_id_ in varchar2,
  thoidiembatdau_ in varchar2,
  thoidiemketthuc_ in varchar2,
  thoigianmll_ in varchar2,
  nguyennhan_ in varchar2,
  phuonganxuly_ in varchar2,
  nguoixacnhan_ in varchar2,
  giamtrumll_ in varchar2,
  trangthai_ in varchar2,
  usercreate_ in varchar2,
  timecreate_ in varchar2,
  deleted_ in varchar2,
  filename_ in varchar2,
  filepath_ in varchar2,
  filesize_ in varchar2,
  bienbanvanhanh_id_ in varchar2
)
RETURN NUMBER AS i INTEGER :=0; 
BEGIN
  IF(id_ IS NOT NULL AND id_ >0) THEN --update
    UPDATE SUCOKENH 
    SET TUYENKENH_ID= tuyenkenh_id_, 
        PHULUC_ID= phuluc_id_, 
        THANHTOAN_ID= thanhtoan_id_, 
        THOIDIEMBATDAU= thoidiembatdau_, 
        THOIDIEMKETTHUC= thoidiemketthuc_,
        THOIGIANMLL= thoigianmll_,
        NGUYENNHAN= nguyennhan_,
        PHUONGANXULY= phuonganxuly_,
        NGUOIXACNHAN= nguoixacnhan_,
        GIAMTRUMLL= giamtrumll_,
        TRANGTHAI= trangthai_,
        DELETED= deleted_,
        FILENAME= filename_,
        FILEPATH= filepath_,
        FILESIZE= filesize_,
        BIENBANVANHANH_ID=bienbanvanhanh_id_
    WHERE ID= id_;
    i:= id_;
  ELSE -- insert
    i:=SEQ_SUCO.nextval;
    INSERT INTO SUCOKENH(ID,TUYENKENH_ID,PHULUC_ID,THANHTOAN_ID,THOIDIEMBATDAU,THOIDIEMKETTHUC,THOIGIANMLL,NGUYENNHAN,PHUONGANXULY,NGUOIXACNHAN,GIAMTRUMLL,TRANGTHAI,USERCREATE,TIMECREATE,DELETED,FILENAME,FILEPATH,FILESIZE,BIENBANVANHANH_ID) 
    VALUES (i, tuyenkenh_id_, phuluc_id_, thanhtoan_id_, thoidiembatdau_, thoidiemketthuc_, thoigianmll_, nguyennhan_, phuonganxuly_, nguoixacnhan_, giamtrumll_, trangthai_, usercreate_, timecreate_, 0,filename_, filepath_, filesize_,bienbanvanhanh_id_);
  END IF;
  RETURN i;
END SAVE_SUCOKENH;

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


