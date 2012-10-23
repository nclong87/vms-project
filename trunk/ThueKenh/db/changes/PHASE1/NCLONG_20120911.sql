--------------------------------------------------------
--  File created - Tuesday-September-11-2012   
--------------------------------------------------------
--------------------------------------------------------
--  DDL for Table TUYENKENH
--------------------------------------------------------
	drop table "TUYENKENH" ; 	
  CREATE TABLE "TUYENKENH" ("ID" NUMBER, "MADIEMDAU" VARCHAR2(50), "MADIEMCUOI" VARCHAR2(50), "GIAOTIEP_ID" NUMBER, "DUAN_ID" NUMBER, "PHONGBAN_ID" NUMBER, "KHUVUC_ID" NUMBER, "DUNGLUONG" NUMBER, "SOLUONG" NUMBER, "NGAYDENGHIBANGIAO" DATE, "NGAYHENBANGIAO" DATE, "THONGTINLIENHE" VARCHAR2(2000), "TRANGTHAI" NUMBER(2,0), "USERCREATE" VARCHAR2(200), "TIMECREATE" DATE, "DELETED" NUMBER(1,0))
REM INSERTING into TUYENKENH
Insert into TUYENKENH (ID,MADIEMDAU,MADIEMCUOI,GIAOTIEP_ID,DUAN_ID,PHONGBAN_ID,KHUVUC_ID,DUNGLUONG,SOLUONG,NGAYDENGHIBANGIAO,NGAYHENBANGIAO,THONGTINLIENHE,TRANGTHAI,USERCREATE,TIMECREATE,DELETED) values (16,'D04','D06',2,null,null,null,1,2,null,null,null,-1,'admin',to_date('11-SEP-12','DD-MON-RR'),0);
Insert into TUYENKENH (ID,MADIEMDAU,MADIEMCUOI,GIAOTIEP_ID,DUAN_ID,PHONGBAN_ID,KHUVUC_ID,DUNGLUONG,SOLUONG,NGAYDENGHIBANGIAO,NGAYHENBANGIAO,THONGTINLIENHE,TRANGTHAI,USERCREATE,TIMECREATE,DELETED) values (5,'D001','D002',1,1,2,1,1,2,to_date('10-SEP-12','DD-MON-RR'),to_date('09-SEP-12','DD-MON-RR'),'www',-1,null,null,0);
Insert into TUYENKENH (ID,MADIEMDAU,MADIEMCUOI,GIAOTIEP_ID,DUAN_ID,PHONGBAN_ID,KHUVUC_ID,DUNGLUONG,SOLUONG,NGAYDENGHIBANGIAO,NGAYHENBANGIAO,THONGTINLIENHE,TRANGTHAI,USERCREATE,TIMECREATE,DELETED) values (12,'D04','D05',1,2,3,1,5,6,to_date('20-SEP-12','DD-MON-RR'),to_date('19-SEP-12','DD-MON-RR'),'dawda',0,null,null,0);
Insert into TUYENKENH (ID,MADIEMDAU,MADIEMCUOI,GIAOTIEP_ID,DUAN_ID,PHONGBAN_ID,KHUVUC_ID,DUNGLUONG,SOLUONG,NGAYDENGHIBANGIAO,NGAYHENBANGIAO,THONGTINLIENHE,TRANGTHAI,USERCREATE,TIMECREATE,DELETED) values (13,'D006','D07',1,2,2,3,2,3,to_date('22-SEP-12','DD-MON-RR'),to_date('13-SEP-12','DD-MON-RR'),'wwwdad',-1,'admin',to_date('11-SEP-12','DD-MON-RR'),0);
Insert into TUYENKENH (ID,MADIEMDAU,MADIEMCUOI,GIAOTIEP_ID,DUAN_ID,PHONGBAN_ID,KHUVUC_ID,DUNGLUONG,SOLUONG,NGAYDENGHIBANGIAO,NGAYHENBANGIAO,THONGTINLIENHE,TRANGTHAI,USERCREATE,TIMECREATE,DELETED) values (14,'D003','D001',2,1,2,null,1,2,to_date('19-SEP-12','DD-MON-RR'),to_date('13-SEP-12','DD-MON-RR'),null,2,'admin',to_date('11-SEP-12','DD-MON-RR'),0);
Insert into TUYENKENH (ID,MADIEMDAU,MADIEMCUOI,GIAOTIEP_ID,DUAN_ID,PHONGBAN_ID,KHUVUC_ID,DUNGLUONG,SOLUONG,NGAYDENGHIBANGIAO,NGAYHENBANGIAO,THONGTINLIENHE,TRANGTHAI,USERCREATE,TIMECREATE,DELETED) values (11,'D02','D03',2,2,2,2,2,3,to_date('13-SEP-12','DD-MON-RR'),null,'wdwa',-1,null,null,0);
Insert into TUYENKENH (ID,MADIEMDAU,MADIEMCUOI,GIAOTIEP_ID,DUAN_ID,PHONGBAN_ID,KHUVUC_ID,DUNGLUONG,SOLUONG,NGAYDENGHIBANGIAO,NGAYHENBANGIAO,THONGTINLIENHE,TRANGTHAI,USERCREATE,TIMECREATE,DELETED) values (15,'D04','D06',1,2,2,2,6,23,to_date('26-SEP-12','DD-MON-RR'),to_date('24-SEP-12','DD-MON-RR'),null,1,'admin',to_date('11-SEP-12','DD-MON-RR'),0);
Insert into TUYENKENH (ID,MADIEMDAU,MADIEMCUOI,GIAOTIEP_ID,DUAN_ID,PHONGBAN_ID,KHUVUC_ID,DUNGLUONG,SOLUONG,NGAYDENGHIBANGIAO,NGAYHENBANGIAO,THONGTINLIENHE,TRANGTHAI,USERCREATE,TIMECREATE,DELETED) values (17,'D04','D07',2,null,null,null,4,3,null,null,null,-1,'admin',to_date('11-SEP-12','DD-MON-RR'),0);
--------------------------------------------------------
--  DDL for Index TUYENKENH_PK
--------------------------------------------------------

  CREATE UNIQUE INDEX "TUYENKENH_PK" ON "TUYENKENH" ("ID")
--------------------------------------------------------
--  Constraints for Table TUYENKENH
--------------------------------------------------------

  ALTER TABLE "TUYENKENH" MODIFY ("ID" NOT NULL ENABLE)
 
  ALTER TABLE "TUYENKENH" ADD CONSTRAINT "TUYENKENH_PK" PRIMARY KEY ("ID") ENABLE
  
  
  
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
	v_vcsql := 'select rownum as rn,dulieu.* from (SELECT t0.ID,MADIEMDAU,MADIEMCUOI,t1.LOAIGIAOTIEP,t0.DUNGLUONG,t0.SOLUONG,t2.TENDUAN,t3.TENPHONGBAN,t4.TENKHUVUC,t0.TRANGTHAI FROM TUYENKENH t0 left join LOAIGIAOTIEP t1 on t0.GIAOTIEP_ID = t1.ID left join DUAN t2 on t0.DUAN_ID = t2.ID left join PHONGBAN t3 on t0.PHONGBAN_ID = t3.ID left join KHUVUC t4 on t0.KHUVUC_ID=t4.ID WHERE ' || v_vcsqlwhere || ' order by t0.ID desc) dulieu ';
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
type r_cursor is REF CURSOR;
cursor_ r_cursor;
tuyenkenh_ TUYENKENH%rowtype;
n_trangthai number:=-2;
BEGIN
	if(id_ is not null and id_>0) then --update
    open cursor_ for select * from tuyenkenh where id=id_;
    fetch cursor_ into tuyenkenh_;
    if(cursor_%notfound = false) then 
      if(tuyenkenh_.DUNGLUONG!=dungluong_) then
        n_trangthai:=1;
      elsif (tuyenkenh_.SOLUONG != soluong_) then
        n_trangthai:=2;
      end if;
    end if;
    close cursor_;
    if(n_trangthai = -2) then
      update TUYENKENH set DUAN_ID = duan_id_,PHONGBAN_ID = phongban_id_,KHUVUC_ID = khuvuc_id_,DUNGLUONG = dungluong_,SOLUONG = soluong_,NGAYDENGHIBANGIAO = ngaydenghibangiao_,NGAYHENBANGIAO = ngayhenbangiao_,THONGTINLIENHE = thongtinlienhe_ where ID = id_;
    else
      update TUYENKENH set DUAN_ID = duan_id_,PHONGBAN_ID = phongban_id_,KHUVUC_ID = khuvuc_id_,DUNGLUONG = dungluong_,SOLUONG = soluong_,NGAYDENGHIBANGIAO = ngaydenghibangiao_,NGAYHENBANGIAO = ngayhenbangiao_,THONGTINLIENHE = thongtinlienhe_,TRANGTHAI = n_trangthai where ID = id_;
    end if;
		
		i := id_;
	else --insert
		i:=SEQ_TUYENKENH.nextval;
		
		insert into TUYENKENH(ID, MADIEMDAU, MADIEMCUOI, GIAOTIEP_ID, DUAN_ID, PHONGBAN_ID, KHUVUC_ID, DUNGLUONG, SOLUONG, NGAYDENGHIBANGIAO, NGAYHENBANGIAO, THONGTINLIENHE, TRANGTHAI, USERCREATE, TIMECREATE, DELETED) values (i, diemdau_id_, diemcuoi_id_, giaotiep_id_, duan_id_, phongban_id_, khuvuc_id_, dungluong_, soluong_, ngaydenghibangiao_, ngayhenbangiao_, thongtinlienhe_, -1, usercreate_, timecreate_, 0);
	end if;
	return i;
END SAVE_TUYENKENH;
