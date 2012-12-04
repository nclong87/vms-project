CREATE TABLE ACCOUNT_KHUVUC 
(
  ACCOUNT_ID NUMBER NOT NULL 
, KHUVUC_ID NUMBER NOT NULL 
, CONSTRAINT USER_KHUVUC_PK PRIMARY KEY 
  (
    ACCOUNT_ID 
  , KHUVUC_ID 
  )
  ENABLE 
);

--------------------------------------------------------
--  DDL for Procedure PROC_SAVE_ACCOUNTKHUVUC
--------------------------------------------------------
set define off;

  CREATE OR REPLACE PROCEDURE "THUEKENH"."PROC_SAVE_ACCOUNTKHUVUC" (
pi_array in TABLE_VARCHAR,
pi_id in VARCHAR2
) AS 
i INTEGER := 1;
BEGIN
	delete from ACCOUNT_KHUVUC where ACCOUNT_ID = pi_id;
  if(pi_array.COUNT() = 0 ) then 
    return;
  end if;
	LOOP
		INSERT  INTO ACCOUNT_KHUVUC (ACCOUNT_ID,KHUVUC_ID) VALUES(pi_id,pi_array(i));
		EXIT WHEN(i = pi_array.COUNT());
		i := i + 1;
	END LOOP;
END PROC_SAVE_ACCOUNTKHUVUC;

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
account_id in varchar2,
phongban_id in varchar2,
isAllow in varchar2,
iTrangThai in nvarchar2
) RETURN SYS_REFCURSOR AS
l_cursor SYS_REFCURSOR;
v_vcsql VARCHAR2(2000);
v_vcsqlwhere VARCHAR2(1000);
i NUMBER;
BEGIN
	v_vcsqlwhere := ' t.DELETED = 0 ';--and t0.khuvuc_id='''||khuvuc_id||'''';
  if(isAllow = '0' ) then
		v_vcsqlwhere := v_vcsqlwhere || 'and t4.khuvuc_id in (select KHUVUC_ID from ACCOUNT_KHUVUC where ACCOUNT_ID ='||account_id||') and t0.PHONGBAN_ID ='''||phongban_id||'''';
	end if;

  if(dexuat_id_ is not null) then
		v_vcsqlwhere := v_vcsqlwhere ||' and t.DEXUAT_ID = '||dexuat_id_||' ';
	end if;
	if(makenh_ is not null) then
		v_vcsqlwhere := v_vcsqlwhere ||' and t0.ID like '''||replace(makenh_, '*', '%')||'%'' ';
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
              SELECT t.ID as ID,t0.ID as TUYENKENH_ID,MADIEMDAU,MADIEMCUOI,t1.LOAIGIAOTIEP,t0.giaotiep_id,t0.DUAN_ID,t0.DUNGLUONG,t.SOLUONG,dx.tenvanban as tenvanbandexuat,t2.tenduan,tiendo,dx.id as MAVANBANDEXUAT,TENPHONGBAN,tendoitac
FROM TUYENKENHDEXUAT t 
left join TUYENKENH t0 on t.TUYENKENH_ID = t0.ID 
left join LOAIGIAOTIEP t1 on t0.GIAOTIEP_ID = t1.ID 
left join DUAN t2 on t0.DUAN_ID = t2.ID 
left join PHONGBAN t3 on t0.PHONGBAN_ID = t3.ID
left join Doitac t4 on t0.DoiTac_id = t4.ID
left join dexuat dx on dx.id=t.dexuat_id
where  t.trangthai='||iTrangThai||' and '|| v_vcsqlwhere || ' order by t0.ID desc) dulieu ';
	v_vcsql := 'SELECT * FROM (' || v_vcsql || ') WHERE rn >= ' || iDisplayStart || ' and rn <= ' || (iDisplayStart+iDisplayLength);
	--dbms_output.put_line(v_vcsql);
 test(v_vcsql);
	OPEN l_cursor FOR v_vcsql;
	RETURN l_cursor;
END FIND_TUYENKENHBANGIAO;

/

