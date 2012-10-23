delete from menu where id=12 or id=14;
Insert into MENU (ID,NAMEMENU,ACTION,ACTIVE,IDROOTMENU) values (14,'Quản lý biên bản bàn giao kênh','/bangiao/index.action',1,3);
Insert into MENU (ID,NAMEMENU,ACTION,ACTIVE,IDROOTMENU) values (12,'Quản lý tiến độ bàn giao kênh','/tiendobangiao/index.action',1,1);

create or replace
FUNCTION            "FIND_BANGIAO" (
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