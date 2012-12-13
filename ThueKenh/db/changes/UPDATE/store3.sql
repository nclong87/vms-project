--------------------------------------------------------
--  DDL for Function FIND_CHITIETPHULUCBYID
--------------------------------------------------------

  CREATE OR REPLACE FUNCTION "THUEKENH"."FIND_CHITIETPHULUCBYID" (
iDisplayStart IN NUMBER,   
iDisplayLength IN NUMBER, 
chitietphulucid_ in varchar2
) RETURN SYS_REFCURSOR AS
l_cursor SYS_REFCURSOR;
v_vcsql VARCHAR2(2000);
v_vcsqlwhere VARCHAR2(1000);
i NUMBER;
BEGIN
	v_vcsqlwhere := 'c.CHITIETPHULUC_ID = '|| chitietphulucid_ ||' ';
	v_vcsql := 'select rownum as rn,dulieu.* from (SELECT c.*,t.ID,t.MADIEMDAU,t.MADIEMCUOI,lgt.LOAIGIAOTIEP,t.DUNGLUONG,t.SOLUONG as SLTUYENKENH 
                                                 FROM CHITIETPHULUC_TUYENKENH c
                                                 INNER JOIN TUYENKENH t ON c.TUYENKENH_ID=t.ID
                                                 INNER JOIN LOAIGIAOTIEP lgt ON t.GIAOTIEP_ID=lgt.ID
                                                 WHERE ' || v_vcsqlwhere || ' order by t.ID desc) dulieu ';
	v_vcsql := 'SELECT * FROM (' || v_vcsql || ') WHERE rn > ' || iDisplayStart || ' and rn <= ' || (iDisplayStart+iDisplayLength);
	--dbms_output.put_line(v_vcsql);
 --test(v_vcsql);
	OPEN l_cursor FOR v_vcsql;
	RETURN l_cursor;
END FIND_CHITIETPHULUCBYID;

/

--------------------------------------------------------
--  DDL for Function SAVE_CHITIETPHULUC
--------------------------------------------------------

  CREATE OR REPLACE FUNCTION "THUEKENH"."SAVE_CHITIETPHULUC" (
id_ in VARCHAR2,
tenchitietphuluc_ in VARCHAR2,
cuocdaunoi_ in VARCHAR2,
giatritruocthue_ in VARCHAR2,
giatrisauthue_ in VARCHAR2,
usercreate_ in VARCHAR2,
timecreate_ in VARCHAR2,
soluongkenh_ in VARCHAR2
) RETURN NUMBER AS
i INTEGER := 0;
BEGIN
	if(id_ is not null) then --update
    delete from CHITIETPHULUC_TUYENKENH WHERE CHITIETPHULUC_ID=id_;
		update CHITIETPHULUC set TENCHITIETPHULUC = tenchitietphuluc_,CUOCDAUNOI = cuocdaunoi_,GIATRITRUOCTHUE = giatritruocthue_,GIATRISAUTHUE = giatrisauthue_,SOLUONGKENH = soluongkenh_ where ID = id_;
		i := id_;
	else --insert
		i:=SEQ_CHITIETPHULUC.nextval;
		
		insert into CHITIETPHULUC(ID,TENCHITIETPHULUC,CUOCDAUNOI,GIATRITRUOCTHUE,GIATRISAUTHUE,USERCREATE,TIMECREATE,DELETED,SOLUONGKENH) values (i,tenchitietphuluc_,cuocdaunoi_,giatritruocthue_,giatrisauthue_,usercreate_,timecreate_,0,soluongkenh_);
	end if;
	insert into CHITIETPHULUC_TUYENKENH(CHITIETPHULUC_ID,TUYENKENH_ID,CONGTHUC_ID,SOLUONG,CUOCCONG,CUOCDAUNOI,DONGIA,GIAMGIA,THANHTIEN) select i,TUYENKENH_ID,CONGTHUC_ID,SOLUONG,CUOCCONG,CUOCDAUNOI,DONGIA,GIAMGIA,THANHTIEN from CHITIETPHULUC_TUYENKENH_TMP;
	return i;
END SAVE_CHITIETPHULUC;

/

