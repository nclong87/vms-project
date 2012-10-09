--------------------------------------------------------
--  DDL for Procedure PROC_IMPORT_SUCO
--------------------------------------------------------
set define off;

  CREATE OR REPLACE PROCEDURE "THUEKENH"."PROC_IMPORT_SUCO" (
pi_array in TABLE_NUMBER,
usercreate_ in varchar2,
timecreate_ in date
) AS 
i INTEGER := 1;
BEGIN
	for rec in (SELECT *  FROM SUCO_IMPORT  where ID in (select * from table(pi_array))) loop
      i := SEQ_SUCO.nextval;
			insert into SUCOKENH(ID,TUYENKENH_ID,PHULUC_ID,THANHTOAN_ID,THOIDIEMBATDAU,THOIDIEMKETTHUC,THOIGIANMLL,NGUYENNHAN,PHUONGANXULY,NGUOIXACNHAN,GIAMTRUMLL,TRANGTHAI,USERCREATE,TIMECREATE,DELETED,BIENBANVANHANH_ID) 
      values (i,rec.TUYENKENH_ID,rec.PHULUC_ID,null,rec.THOIDIEMBATDAU,rec.THOIDIEMKETTHUC,rec.THOIGIANMLL,rec.NGUYENNHAN,rec.PHUONGANXULY,rec.NGUOIXACNHAN,rec.GIAMTRUMLL,0,usercreate_,timecreate_,0,0);
    delete from SUCO_IMPORT where ID = rec.ID;
	end loop;
END PROC_IMPORT_SUCO;

/

