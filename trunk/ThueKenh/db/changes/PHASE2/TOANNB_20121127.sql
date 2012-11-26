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
	v_vcsql := 'select rownum as rn,dulieu.* from (SELECT tt.*,dsc.thanhtien giatritt,dsc.giamtrumll,extract(month from dsc.DENNGAY) as thang,extract(year from dsc.DENNGAY) as nam
                                                 FROM THANHTOAN tt INNER JOIN DOISOATCUOC dsc ON tt.DOISOATCUOC_ID=dsc.ID 
                                                 WHERE ' || v_vcsqlwhere || ' order by tt.TIMECREATE desc) dulieu ';
	v_vcsql := 'SELECT * FROM (' || v_vcsql || ') WHERE rn > ' || iDisplayStart || ' and rn <= ' || (iDisplayStart+iDisplayLength);
	dbms_output.put_line(v_vcsql);
 --test(v_vcsql);
	OPEN l_cursor FOR v_vcsql;
	RETURN l_cursor;
END FIND_HOSOTHANHTOAN;

/

