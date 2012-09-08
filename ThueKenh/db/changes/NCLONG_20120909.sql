--------------------------------------------------------
--  File created - Sunday-September-09-2012   
--------------------------------------------------------
REM INSERTING into THUEKENH.MENU
Insert into THUEKENH.MENU (ID,NAMEMENU,ACTION,ACTIVE,IDROOTMENU) values (4,'Phòng ban','/danhmuc/phongban.action',1,8);
Insert into THUEKENH.MENU (ID,NAMEMENU,ACTION,ACTIVE,IDROOTMENU) values (2,'Quản trị nhóm','/group/index.action',1,7);
Insert into THUEKENH.MENU (ID,NAMEMENU,ACTION,ACTIVE,IDROOTMENU) values (3,'Quản trị quyền','/menu/index.action',1,7);
Insert into THUEKENH.MENU (ID,NAMEMENU,ACTION,ACTIVE,IDROOTMENU) values (1,'Quản trị user','/user/index.action',1,7);
Insert into THUEKENH.MENU (ID,NAMEMENU,ACTION,ACTIVE,IDROOTMENU) values (5,'Đối tác','/danhmuc/doitac.action',1,8);
Insert into THUEKENH.MENU (ID,NAMEMENU,ACTION,ACTIVE,IDROOTMENU) values (6,'Dự án','/danhmuc/duan.action',1,8);
Insert into THUEKENH.MENU (ID,NAMEMENU,ACTION,ACTIVE,IDROOTMENU) values (7,'Loại dự cố','/danhmuc/phongban.action',1,8);
Insert into THUEKENH.MENU (ID,NAMEMENU,ACTION,ACTIVE,IDROOTMENU) values (8,'Tiêu chí bàn giao kênh','/danhmuc/phongban.action',1,8);
Insert into THUEKENH.MENU (ID,NAMEMENU,ACTION,ACTIVE,IDROOTMENU) values (9,'Khu vực','/danhmuc/khuvuc.action',1,8);
Insert into THUEKENH.MENU (ID,NAMEMENU,ACTION,ACTIVE,IDROOTMENU) values (10,'Quản lý tuyến kênh','/tuyenkenh/index.action',1,1);
Insert into THUEKENH.MENU (ID,NAMEMENU,ACTION,ACTIVE,IDROOTMENU) values (11,'Import tuyến kênh','/import/tuyenkenh.action',1,1);
Insert into THUEKENH.MENU (ID,NAMEMENU,ACTION,ACTIVE,IDROOTMENU) values (12,'Quản lý tiến độ bàn giao kênh','/bangiao/index.action',1,1);
Insert into THUEKENH.MENU (ID,NAMEMENU,ACTION,ACTIVE,IDROOTMENU) values (13,'Quản lý văn bản đề xuất',null,1,3);
Insert into THUEKENH.MENU (ID,NAMEMENU,ACTION,ACTIVE,IDROOTMENU) values (14,'Quản lý biên bản bàn giao kênh',null,1,3);
Insert into THUEKENH.MENU (ID,NAMEMENU,ACTION,ACTIVE,IDROOTMENU) values (15,'Quản lý biên bản vận hành kênh',null,1,3);
Insert into THUEKENH.MENU (ID,NAMEMENU,ACTION,ACTIVE,IDROOTMENU) values (16,'Quản lý hợp đồng',null,1,4);
Insert into THUEKENH.MENU (ID,NAMEMENU,ACTION,ACTIVE,IDROOTMENU) values (17,'Quản lý phụ lục hợp đồng',null,1,4);
Insert into THUEKENH.MENU (ID,NAMEMENU,ACTION,ACTIVE,IDROOTMENU) values (18,'Báo cáo tiến độ',null,1,5);
Insert into THUEKENH.MENU (ID,NAMEMENU,ACTION,ACTIVE,IDROOTMENU) values (19,'Xuất bảng đối soát cước',null,1,5);
Insert into THUEKENH.MENU (ID,NAMEMENU,ACTION,ACTIVE,IDROOTMENU) values (20,'Báo cáo giảm trừ mất liên lạc',null,1,5);
Insert into THUEKENH.MENU (ID,NAMEMENU,ACTION,ACTIVE,IDROOTMENU) values (21,'Báo cáo sự cố theo thời gian',null,1,5);



--------------------------------------------------------
--  File created - Sunday-September-09-2012   
--------------------------------------------------------
ALTER TABLE ROOTMENU 
ADD (URL VARCHAR2(200) );

REM INSERTING into THUEKENH.ROOTMENU
Insert into THUEKENH.ROOTMENU (ID,NAME) values (1,'TUYẾN KÊNH');
Insert into THUEKENH.ROOTMENU (ID,NAME) values (2,'SỰ CỐ KÊNH');
Insert into THUEKENH.ROOTMENU (ID,NAME) values (3,'QUẢN LÝ VĂN BẢN');
Insert into THUEKENH.ROOTMENU (ID,NAME) values (4,'QUẢN LÝ HỢP ĐỒNG');
Insert into THUEKENH.ROOTMENU (ID,NAME) values (5,'QUẢN LÝ HỒ SƠ TT');
Insert into THUEKENH.ROOTMENU (ID,NAME) values (6,'HỆ THỐNG BÁO CÁO');
Insert into THUEKENH.ROOTMENU (ID,NAME) values (7,'QUẢN TRỊ');
Insert into THUEKENH.ROOTMENU (ID,NAME) values (8,'DANH  MỤC');
