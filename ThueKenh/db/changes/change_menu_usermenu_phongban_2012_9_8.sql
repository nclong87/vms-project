CREATE SEQUENCE  "THUEKHOAN"."SEQ_PHONGBAN"  MINVALUE 1 MAXVALUE 999999999 INCREMENT BY 1 START WITH 24 CACHE 20 NOORDER  NOCYCLE ;

create or replace
PROCEDURE PROC_SAVE_PHONGBAN (
  id_	in number,
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


--------------------------------------------------------
--  File created - Sunday-September-09-2012   
--------------------------------------------------------
REM INSERTING into THUEKHOAN.MENU
SET DEFINE OFF;
Insert into THUEKHOAN.MENU (ID,NAMEMENU,ACTION,ACTIVE,IDROOTMENU) values (4,'Phòng ban','/danhmuc/phongban.action',1,2);
Insert into THUEKHOAN.MENU (ID,NAMEMENU,ACTION,ACTIVE,IDROOTMENU) values (2,'Quản trị nhóm','/group/index.action',1,1);
Insert into THUEKHOAN.MENU (ID,NAMEMENU,ACTION,ACTIVE,IDROOTMENU) values (3,'Quản trị quyền','/menu/index.action',1,1);
Insert into THUEKHOAN.MENU (ID,NAMEMENU,ACTION,ACTIVE,IDROOTMENU) values (1,'Quản trị user','/user/index.action',1,1);
Insert into THUEKHOAN.MENU (ID,NAMEMENU,ACTION,ACTIVE,IDROOTMENU) values (5,'Đối tác','/danhmuc/doitac.action',1,2);
Insert into THUEKHOAN.MENU (ID,NAMEMENU,ACTION,ACTIVE,IDROOTMENU) values (6,'Dự án','/danhmuc/duan.action',1,2);
Insert into THUEKHOAN.MENU (ID,NAMEMENU,ACTION,ACTIVE,IDROOTMENU) values (7,'Loại dự cố','/danhmuc/phongban.action',1,2);
Insert into THUEKHOAN.MENU (ID,NAMEMENU,ACTION,ACTIVE,IDROOTMENU) values (8,'Tiêu chí bàn giao kênh','/danhmuc/phongban.action',1,2);
Insert into THUEKHOAN.MENU (ID,NAMEMENU,ACTION,ACTIVE,IDROOTMENU) values (9,'Khu vực','/danhmuc/khuvuc.action',1,2);
REM INSERTING into THUEKHOAN.USER_MENU
SET DEFINE OFF;
Insert into THUEKHOAN.USER_MENU (ACCOUNTID,MENUID) values (0,1);
Insert into THUEKHOAN.USER_MENU (ACCOUNTID,MENUID) values (0,2);
Insert into THUEKHOAN.USER_MENU (ACCOUNTID,MENUID) values (0,3);
Insert into THUEKHOAN.USER_MENU (ACCOUNTID,MENUID) values (0,4);
Insert into THUEKHOAN.USER_MENU (ACCOUNTID,MENUID) values (0,5);
Insert into THUEKHOAN.USER_MENU (ACCOUNTID,MENUID) values (0,6);
Insert into THUEKHOAN.USER_MENU (ACCOUNTID,MENUID) values (0,7);
Insert into THUEKHOAN.USER_MENU (ACCOUNTID,MENUID) values (0,8);
Insert into THUEKHOAN.USER_MENU (ACCOUNTID,MENUID) values (0,9);





