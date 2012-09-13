--------------------------------------------------------
--  File created - Thursday-September-13-2012   
--------------------------------------------------------
REM INSERTING into THUEKHOAN.MENU
SET DEFINE OFF;
Insert into THUEKHOAN.MENU (ID,NAMEMENU,ACTION,ACTIVE,IDROOTMENU) values (24,'Loại giao tiếp','/danhmuc/loaigiaotiep.action',1,8);
Insert into THUEKHOAN.MENU (ID,NAMEMENU,ACTION,ACTIVE,IDROOTMENU) values (4,'Phòng ban','/danhmuc/phongban.action',1,8);
Insert into THUEKHOAN.MENU (ID,NAMEMENU,ACTION,ACTIVE,IDROOTMENU) values (2,'Quản trị nhóm','/group/index.action',1,7);
Insert into THUEKHOAN.MENU (ID,NAMEMENU,ACTION,ACTIVE,IDROOTMENU) values (3,'Quản trị quyền','/menu/index.action',1,7);
Insert into THUEKHOAN.MENU (ID,NAMEMENU,ACTION,ACTIVE,IDROOTMENU) values (1,'Quản trị user','/user/index.action',1,7);
Insert into THUEKHOAN.MENU (ID,NAMEMENU,ACTION,ACTIVE,IDROOTMENU) values (5,'Đối tác','/danhmuc/doitac.action',1,8);
Insert into THUEKHOAN.MENU (ID,NAMEMENU,ACTION,ACTIVE,IDROOTMENU) values (6,'Dự án','/danhmuc/duan.action',1,8);
Insert into THUEKHOAN.MENU (ID,NAMEMENU,ACTION,ACTIVE,IDROOTMENU) values (7,'Loại dự cố','/danhmuc/phongban.action',1,8);
Insert into THUEKHOAN.MENU (ID,NAMEMENU,ACTION,ACTIVE,IDROOTMENU) values (8,'Tiêu chí bàn giao kênh','/danhmuc/phongban.action',1,8);
Insert into THUEKHOAN.MENU (ID,NAMEMENU,ACTION,ACTIVE,IDROOTMENU) values (9,'Khu vực','/danhmuc/khuvuc.action',1,8);
Insert into THUEKHOAN.MENU (ID,NAMEMENU,ACTION,ACTIVE,IDROOTMENU) values (10,'Quản lý tuyến kênh','/tuyenkenh/index.action',1,1);
Insert into THUEKHOAN.MENU (ID,NAMEMENU,ACTION,ACTIVE,IDROOTMENU) values (11,'Import tuyến kênh','/import/tuyenkenh.action',1,1);
Insert into THUEKHOAN.MENU (ID,NAMEMENU,ACTION,ACTIVE,IDROOTMENU) values (12,'Quản lý tiến độ bàn giao kênh','/bangiao/index.action',1,1);
Insert into THUEKHOAN.MENU (ID,NAMEMENU,ACTION,ACTIVE,IDROOTMENU) values (13,'Quản lý văn bản đề xuất',null,1,3);
Insert into THUEKHOAN.MENU (ID,NAMEMENU,ACTION,ACTIVE,IDROOTMENU) values (14,'Quản lý biên bản bàn giao kênh',null,1,3);
Insert into THUEKHOAN.MENU (ID,NAMEMENU,ACTION,ACTIVE,IDROOTMENU) values (15,'Quản lý biên bản vận hành kênh',null,1,3);
Insert into THUEKHOAN.MENU (ID,NAMEMENU,ACTION,ACTIVE,IDROOTMENU) values (16,'Quản lý hợp đồng',null,1,4);
Insert into THUEKHOAN.MENU (ID,NAMEMENU,ACTION,ACTIVE,IDROOTMENU) values (17,'Quản lý phụ lục hợp đồng',null,1,4);
Insert into THUEKHOAN.MENU (ID,NAMEMENU,ACTION,ACTIVE,IDROOTMENU) values (18,'Báo cáo tiến độ',null,1,6);
Insert into THUEKHOAN.MENU (ID,NAMEMENU,ACTION,ACTIVE,IDROOTMENU) values (19,'Xuất bảng đối soát cước',null,1,6);
Insert into THUEKHOAN.MENU (ID,NAMEMENU,ACTION,ACTIVE,IDROOTMENU) values (20,'Báo cáo giảm trừ mất liên lạc',null,1,6);
Insert into THUEKHOAN.MENU (ID,NAMEMENU,ACTION,ACTIVE,IDROOTMENU) values (21,'Báo cáo sự cố theo thời gian',null,1,6);
Insert into THUEKHOAN.MENU (ID,NAMEMENU,ACTION,ACTIVE,IDROOTMENU) values (22,'SỰ CỐ KÊNH','/sucokenh/index.action',1,2);
Insert into THUEKHOAN.MENU (ID,NAMEMENU,ACTION,ACTIVE,IDROOTMENU) values (23,'QUẢN LÝ HỒ SƠ TT','/thanhtoan/index.action',1,5);
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
Insert into THUEKHOAN.USER_MENU (ACCOUNTID,MENUID) values (0,10);
Insert into THUEKHOAN.USER_MENU (ACCOUNTID,MENUID) values (0,11);
Insert into THUEKHOAN.USER_MENU (ACCOUNTID,MENUID) values (0,24);
