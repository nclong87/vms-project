--------------------------------------------------------
--  File created - Thursday-September-13-2012   
--------------------------------------------------------
  DROP SEQUENCE "THUEKHOAN"."SEQ_CONGTHUC";
  DROP SEQUENCE "THUEKHOAN"."SEQ_DOITAC";
  DROP SEQUENCE "THUEKHOAN"."SEQ_DUAN";
  DROP SEQUENCE "THUEKHOAN"."SEQ_KHUVUC";
  DROP SEQUENCE "THUEKHOAN"."SEQ_LOAIGIAOTIEP";
  DROP SEQUENCE "THUEKHOAN"."SEQ_PHONGBAN";
--------------------------------------------------------
--  DDL for Sequence SEQ_CONGTHUC
--------------------------------------------------------

   CREATE SEQUENCE  "THUEKHOAN"."SEQ_CONGTHUC"  MINVALUE 1 MAXVALUE 999999999 INCREMENT BY 1 START WITH 21 CACHE 20 NOORDER  NOCYCLE ;
--------------------------------------------------------
--  DDL for Sequence SEQ_DOITAC
--------------------------------------------------------

   CREATE SEQUENCE  "THUEKHOAN"."SEQ_DOITAC"  MINVALUE 1 MAXVALUE 9999999 INCREMENT BY 1 START WITH 61 CACHE 20 NOORDER  NOCYCLE ;
--------------------------------------------------------
--  DDL for Sequence SEQ_DUAN
--------------------------------------------------------

   CREATE SEQUENCE  "THUEKHOAN"."SEQ_DUAN"  MINVALUE 1 MAXVALUE 99999999 INCREMENT BY 1 START WITH 22 CACHE 20 NOORDER  NOCYCLE ;
--------------------------------------------------------
--  DDL for Sequence SEQ_KHUVUC
--------------------------------------------------------

   CREATE SEQUENCE  "THUEKHOAN"."SEQ_KHUVUC"  MINVALUE 1 MAXVALUE 99999999 INCREMENT BY 1 START WITH 6 CACHE 20 NOORDER  NOCYCLE ;
--------------------------------------------------------
--  DDL for Sequence SEQ_LOAIGIAOTIEP
--------------------------------------------------------

   CREATE SEQUENCE  "THUEKHOAN"."SEQ_LOAIGIAOTIEP"  MINVALUE 1 MAXVALUE 999999 INCREMENT BY 1 START WITH 61 CACHE 20 NOORDER  NOCYCLE ;
--------------------------------------------------------
--  DDL for Sequence SEQ_PHONGBAN
--------------------------------------------------------

   CREATE SEQUENCE  "THUEKHOAN"."SEQ_PHONGBAN"  MINVALUE 1 MAXVALUE 999999999 INCREMENT BY 1 START WITH 124 CACHE 20 NOORDER  NOCYCLE ;

   
   
   --------------------------------------------------------
--  File created - Thursday-September-13-2012   
--------------------------------------------------------
--------------------------------------------------------
--  DDL for Procedure PROC_SAVE_PHONGBAN
--------------------------------------------------------
set define off;

  CREATE OR REPLACE PROCEDURE "THUEKHOAN"."PROC_SAVE_PHONGBAN" (
  id_	in nvarchar2,
	name_ in VARCHAR2,
	stt_ IN number,
  deleted_ IN number
) AS 
i INTEGER := 0;
BEGIN
		if(id_ is not null and id_>0) then --update
      update PHONGBAN set TENPHONGBAN = name_ where ID = id_;
	else --insert
		i:=SEQ_PHONGBAN.nextval;
		insert into PHONGBAN(ID,TENPHONGBAN,DELETED,STT) values (i,name_,deleted_,stt_);
  end if;
END PROC_SAVE_PHONGBAN;

/
--------------------------------------------------------
--  DDL for Procedure PROC_SAVE_LOAIGIAOTIEP
--------------------------------------------------------
set define off;

  CREATE OR REPLACE PROCEDURE "THUEKHOAN"."PROC_SAVE_LOAIGIAOTIEP" (
  id_	in number,
	name_ in VARCHAR2,
	cuoccong_ IN number,
  deleted_ IN number
) AS 
i INTEGER := 0;
BEGIN

    --i=0 update
      if(id_ is not null and id_>0) then --update
        update LOAIGIAOTIEP set LOAIGIAOTIEP = name_,CUOCCONG=cuoccong_ where ID = id_;
    else --insert
    --i=n insert
      i:=SEQ_LOAIGIAOTIEP.nextval;
      insert into LOAIGIAOTIEP(ID,LOAIGIAOTIEP,DELETED,CUOCCONG) values (i,name_,deleted_,cuoccong_);
    end if;

END PROC_SAVE_LOAIGIAOTIEP;

/
--------------------------------------------------------
--  DDL for Procedure PROC_SAVE_KHUVUC
--------------------------------------------------------
set define off;

  CREATE OR REPLACE PROCEDURE "THUEKHOAN"."PROC_SAVE_KHUVUC" (
  id_	in nvarchar2,
	name_ in VARCHAR2,
	stt_ IN number,
  deleted_ IN number
) AS 
i INTEGER := 0;
BEGIN
		if(id_ is not null and id_>0) then --update
      update KHUVUC set TENKHUVUC = name_ where ID = id_;
	else --insert
		i:=SEQ_PHONGBAN.nextval;
		insert into KHUVUC(ID,TENKHUVUC,DELETED,STT) values (i,name_,deleted_,stt_);
  end if;
END PROC_SAVE_KHUVUC;

/
--------------------------------------------------------
--  DDL for Procedure PROC_SAVE_DUAN
--------------------------------------------------------
set define off;

  CREATE OR REPLACE PROCEDURE "THUEKHOAN"."PROC_SAVE_DUAN" (
  id_	in nvarchar2,
	name_ in VARCHAR2,
	stt_ IN number,
  deleted_ IN number,
  mota_ in nvarchar2,
  giamgia_ in number,
  usercreate_ in varchar2
) AS 
i INTEGER := 0;
BEGIN
		i:=SEQ_DUAN.nextval;
		insert into DUAN(ID,TENDUAN,DELETED,STT,MOTA,GIAMGIA,USERCREATE,TIMECREATE) values (i,name_,deleted_,stt_,mota_,giamgia_,usercreate_,sysdate);
END PROC_SAVE_DUAN;

/
--------------------------------------------------------
--  DDL for Procedure PROC_SAVE_DOITAC
--------------------------------------------------------
set define off;

  CREATE OR REPLACE PROCEDURE "THUEKHOAN"."PROC_SAVE_DOITAC" (
  id_	in nvarchar2,
	name_ in VARCHAR2,
	stt_ IN number,
  deleted_ IN number
) AS 
i INTEGER := 0;
BEGIN
		if(id_ is not null and id_>0) then --update
      update DOITAC set TENDOITAC = name_ where ID = id_;
	else --insert
		i:=SEQ_DOITAC.nextval;
		insert into DOITAC(ID,TENDOITAC,DELETED,STT) values (i,name_,deleted_,stt_);
  end if;
END PROC_SAVE_DOITAC;

/
--------------------------------------------------------
--  DDL for Procedure PROC_SAVE_CONGTHUC
--------------------------------------------------------
set define off;

  CREATE OR REPLACE PROCEDURE "THUEKHOAN"."PROC_SAVE_CONGTHUC" (
  id_	in number,
	name_ in VARCHAR2,
  congthuc_ in VARCHAR2,
	usercreate_ in VARCHAR2,
  stt_ IN number,
  deleted_ IN number
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
        usercreate=usercreate_ 
        where ID = id_;
    else --insert
    --i=n insert
      i:=SEQ_CONGTHUC.nextval;
      insert into CONGTHUC(ID,TENCONGTHUC,CHUOICONGTHUC,TIMECREATE,USERCREATE,STT,DELETED)
      VALUES(i,name_,congthuc_,sysdate,usercreate_,stt_,deleted_);
    end if;

END PROC_SAVE_CONGTHUC;

/