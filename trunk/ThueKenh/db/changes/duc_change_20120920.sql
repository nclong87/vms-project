--------------------------------------------------------
--  File created - Thursday-September-20-2012   
--------------------------------------------------------
--------------------------------------------------------
--  DDL for Table DOITAC
--------------------------------------------------------

  CREATE TABLE "THUEKENH"."DOITAC" 
   (	"ID" NUMBER, 
	"TENDOITAC" VARCHAR2(200 BYTE), 
	"DELETED" NUMBER(1,0), 
	"STT" NUMBER DEFAULT 0, 
	"MA" VARCHAR2(20 BYTE)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 NOCOMPRESS LOGGING
  STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1 BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
  TABLESPACE "USERS" ;
--------------------------------------------------------
--  DDL for Table DUAN
--------------------------------------------------------

  CREATE TABLE "THUEKENH"."DUAN" 
   (	"ID" NUMBER, 
	"TENDUAN" VARCHAR2(200 BYTE), 
	"DELETED" NUMBER(1,0), 
	"STT" NUMBER DEFAULT 0, 
	"MOTA" VARCHAR2(1024 BYTE), 
	"GIAMGIA" NUMBER, 
	"USERCREATE" VARCHAR2(1024 BYTE), 
	"TIMECREATE" DATE, 
	"MA" VARCHAR2(20 BYTE)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 NOCOMPRESS LOGGING
  STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1 BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
  TABLESPACE "USERS" ;
--------------------------------------------------------
--  DDL for Table KHUVUC
--------------------------------------------------------

  CREATE TABLE "THUEKENH"."KHUVUC" 
   (	"ID" NUMBER, 
	"TENKHUVUC" VARCHAR2(200 BYTE), 
	"DELETED" NUMBER(1,0), 
	"STT" NUMBER DEFAULT 0, 
	"MA" VARCHAR2(20 BYTE)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 NOCOMPRESS LOGGING
  STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1 BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
  TABLESPACE "USERS" ;
--------------------------------------------------------
--  DDL for Table PHONGBAN
--------------------------------------------------------

  CREATE TABLE "THUEKENH"."PHONGBAN" 
   (	"ID" NUMBER, 
	"TENPHONGBAN" VARCHAR2(200 BYTE), 
	"DELETED" NUMBER(1,0), 
	"STT" NUMBER DEFAULT 0, 
	"MA" VARCHAR2(20 BYTE)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 NOCOMPRESS LOGGING
  STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1 BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
  TABLESPACE "USERS" ;
--------------------------------------------------------
--  DDL for Table MENU
--------------------------------------------------------

  CREATE TABLE "THUEKENH"."MENU" 
   (	"ID" NUMBER, 
	"NAMEMENU" VARCHAR2(200 BYTE), 
	"ACTION" VARCHAR2(50 BYTE), 
	"ACTIVE" NUMBER(1,0), 
	"IDROOTMENU" NUMBER
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 NOCOMPRESS LOGGING
  STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1 BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
  TABLESPACE "USERS" ;
--------------------------------------------------------
--  DDL for Table USER_MENU
--------------------------------------------------------

  CREATE TABLE "THUEKENH"."USER_MENU" 
   (	"ACCOUNTID" NUMBER, 
	"MENUID" NUMBER
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 NOCOMPRESS LOGGING
  STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1 BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
  TABLESPACE "USERS" ;
--------------------------------------------------------
--  DDL for Table TIEUCHUAN
--------------------------------------------------------

  CREATE TABLE "THUEKENH"."TIEUCHUAN" 
   (	"ID" NUMBER, 
	"TENTIEUCHUAN" VARCHAR2(200 BYTE), 
	"LOAITIEUCHUAN" NUMBER(2,0), 
	"MOTA" VARCHAR2(2000 BYTE), 
	"USERCREATE" VARCHAR2(200 BYTE), 
	"TIMECREATE" DATE, 
	"STT" NUMBER(2,0), 
	"DELETED" NUMBER(1,0), 
	"MA" VARCHAR2(20 BYTE)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 NOCOMPRESS LOGGING
  STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1 BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
  TABLESPACE "USERS" ;
--------------------------------------------------------
--  DDL for Table CONGTHUC
--------------------------------------------------------

  CREATE TABLE "THUEKENH"."CONGTHUC" 
   (	"ID" NUMBER, 
	"TENCONGTHUC" VARCHAR2(200 BYTE), 
	"CHUOICONGTHUC" VARCHAR2(200 BYTE), 
	"USERCREATE" VARCHAR2(200 BYTE), 
	"TIMECREATE" DATE, 
	"STT" NUMBER(2,0), 
	"DELETED" NUMBER(1,0), 
	"MA" VARCHAR2(20 BYTE)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 NOCOMPRESS LOGGING
  STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1 BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
  TABLESPACE "USERS" ;
REM INSERTING into THUEKENH.DOITAC
SET DEFINE OFF;
Insert into THUEKENH.DOITAC (ID,TENDOITAC,DELETED,STT,MA) values (1,'Đối tác Vũng Tàu',1,0,'ma');
Insert into THUEKENH.DOITAC (ID,TENDOITAC,DELETED,STT,MA) values (2,'Đối tác Đồng Nai',0,1,'dt1');
Insert into THUEKENH.DOITAC (ID,TENDOITAC,DELETED,STT,MA) values (3,'Đối tác Bình Dương4r45',0,0,null);
Insert into THUEKENH.DOITAC (ID,TENDOITAC,DELETED,STT,MA) values (4,'Đối tác Lâm Đồng',0,0,null);
Insert into THUEKENH.DOITAC (ID,TENDOITAC,DELETED,STT,MA) values (21,'SDFGSDFGSDFG',1,0,null);
Insert into THUEKENH.DOITAC (ID,TENDOITAC,DELETED,STT,MA) values (83,'fads',0,0,'asdfas');
Insert into THUEKENH.DOITAC (ID,TENDOITAC,DELETED,STT,MA) values (93,'phonggggg',0,12,'ma 3');
Insert into THUEKENH.DOITAC (ID,TENDOITAC,DELETED,STT,MA) values (94,'doi tac 2',0,1,'dt2');
Insert into THUEKENH.DOITAC (ID,TENDOITAC,DELETED,STT,MA) values (41,'35u75y54y4',0,0,null);
Insert into THUEKENH.DOITAC (ID,TENDOITAC,DELETED,STT,MA) values (61,'doi tac 1',0,0,'ma 1');
REM INSERTING into THUEKENH.DUAN
SET DEFINE OFF;
Insert into THUEKENH.DUAN (ID,TENDUAN,DELETED,STT,MOTA,GIAMGIA,USERCREATE,TIMECREATE,MA) values (22,null,1,1,'1',1123,'admin',to_date('19-SEP-12','DD-MON-RR'),'ma 1');
Insert into THUEKENH.DUAN (ID,TENDUAN,DELETED,STT,MOTA,GIAMGIA,USERCREATE,TIMECREATE,MA) values (1,'222',0,22,'222',222,'admin',to_date('13-SEP-12','DD-MON-RR'),'2222');
Insert into THUEKENH.DUAN (ID,TENDUAN,DELETED,STT,MOTA,GIAMGIA,USERCREATE,TIMECREATE,MA) values (2,'asdf',0,1,'mota',123,'admin',to_date('13-SEP-12','DD-MON-RR'),null);
Insert into THUEKENH.DUAN (ID,TENDUAN,DELETED,STT,MOTA,GIAMGIA,USERCREATE,TIMECREATE,MA) values (3,'asdf',0,1,'mota',123,'admin',to_date('13-SEP-12','DD-MON-RR'),null);
Insert into THUEKENH.DUAN (ID,TENDUAN,DELETED,STT,MOTA,GIAMGIA,USERCREATE,TIMECREATE,MA) values (4,'asdf',0,1,'mota',123,'admin',to_date('13-SEP-12','DD-MON-RR'),null);
Insert into THUEKENH.DUAN (ID,TENDUAN,DELETED,STT,MOTA,GIAMGIA,USERCREATE,TIMECREATE,MA) values (5,'asdf',0,1,'mota',123,'admin',to_date('13-SEP-12','DD-MON-RR'),null);
Insert into THUEKENH.DUAN (ID,TENDUAN,DELETED,STT,MOTA,GIAMGIA,USERCREATE,TIMECREATE,MA) values (23,'du an 1 ',0,1,'1',1123,'admin',to_date('19-SEP-12','DD-MON-RR'),'ma 1');
Insert into THUEKENH.DUAN (ID,TENDUAN,DELETED,STT,MOTA,GIAMGIA,USERCREATE,TIMECREATE,MA) values (42,'000',0,0,'0000',0,'admin',to_date('20-SEP-12','DD-MON-RR'),'000000');
REM INSERTING into THUEKENH.KHUVUC
SET DEFINE OFF;
Insert into THUEKENH.KHUVUC (ID,TENKHUVUC,DELETED,STT,MA) values (87,'tt66t6t6t6t',1,1,null);
Insert into THUEKENH.KHUVUC (ID,TENKHUVUC,DELETED,STT,MA) values (146,'tên khu vực',1,3,'khu vuc 1');
Insert into THUEKENH.KHUVUC (ID,TENKHUVUC,DELETED,STT,MA) values (5,'111111',0,111,'1111');
Insert into THUEKENH.KHUVUC (ID,TENKHUVUC,DELETED,STT,MA) values (86,'1212',0,1212,'1212');
Insert into THUEKENH.KHUVUC (ID,TENKHUVUC,DELETED,STT,MA) values (89,'wergwrgggggggggggggggggggggggg',0,0,null);
Insert into THUEKENH.KHUVUC (ID,TENKHUVUC,DELETED,STT,MA) values (90,'abc123123123',0,0,null);
Insert into THUEKENH.KHUVUC (ID,TENKHUVUC,DELETED,STT,MA) values (106,'WERGWERG',0,45,null);
Insert into THUEKENH.KHUVUC (ID,TENKHUVUC,DELETED,STT,MA) values (201,'eeeee',0,1,'eeeee');
Insert into THUEKENH.KHUVUC (ID,TENKHUVUC,DELETED,STT,MA) values (202,'1313',0,1313,'1313');
Insert into THUEKENH.KHUVUC (ID,TENKHUVUC,DELETED,STT,MA) values (1,'Vũng Tàu',0,0,null);
Insert into THUEKENH.KHUVUC (ID,TENKHUVUC,DELETED,STT,MA) values (2,'2323',1,0,null);
Insert into THUEKENH.KHUVUC (ID,TENKHUVUC,DELETED,STT,MA) values (3,'Bình Dương',0,0,null);
Insert into THUEKENH.KHUVUC (ID,TENKHUVUC,DELETED,STT,MA) values (4,'Lâm Đồng',0,0,null);
Insert into THUEKENH.KHUVUC (ID,TENKHUVUC,DELETED,STT,MA) values (104,'wergwergwergw',0,4,null);
REM INSERTING into THUEKENH.PHONGBAN
SET DEFINE OFF;
Insert into THUEKENH.PHONGBAN (ID,TENPHONGBAN,DELETED,STT,MA) values (125,null,null,null,null);
Insert into THUEKENH.PHONGBAN (ID,TENPHONGBAN,DELETED,STT,MA) values (184,'sdfbsdfbsd',1,0,null);
Insert into THUEKENH.PHONGBAN (ID,TENPHONGBAN,DELETED,STT,MA) values (185,'phong cui bape',0,5,null);
Insert into THUEKENH.PHONGBAN (ID,TENPHONGBAN,DELETED,STT,MA) values (186,'asdvasdvsv',0,43,null);
Insert into THUEKENH.PHONGBAN (ID,TENPHONGBAN,DELETED,STT,MA) values (187,'ergergeg',1,0,null);
Insert into THUEKENH.PHONGBAN (ID,TENPHONGBAN,DELETED,STT,MA) values (188,'gewgrwerg',0,56,null);
Insert into THUEKENH.PHONGBAN (ID,TENPHONGBAN,DELETED,STT,MA) values (4,'test',1,1,null);
Insert into THUEKENH.PHONGBAN (ID,TENPHONGBAN,DELETED,STT,MA) values (145,'phong 2',1,2,'ma 2');
Insert into THUEKENH.PHONGBAN (ID,TENPHONGBAN,DELETED,STT,MA) values (164,'11111111',0,1111,'1111111');
Insert into THUEKENH.PHONGBAN (ID,TENPHONGBAN,DELETED,STT,MA) values (165,'1',1,1,'1');
Insert into THUEKENH.PHONGBAN (ID,TENPHONGBAN,DELETED,STT,MA) values (24,'abc',1,0,null);
Insert into THUEKENH.PHONGBAN (ID,TENPHONGBAN,DELETED,STT,MA) values (44,'asdfasdfasdf',1,0,null);
Insert into THUEKENH.PHONGBAN (ID,TENPHONGBAN,DELETED,STT,MA) values (45,'asdfasdfd',1,0,null);
Insert into THUEKENH.PHONGBAN (ID,TENPHONGBAN,DELETED,STT,MA) values (46,'minhduc',1,0,null);
Insert into THUEKENH.PHONGBAN (ID,TENPHONGBAN,DELETED,STT,MA) values (47,'minhduc',1,0,null);
Insert into THUEKENH.PHONGBAN (ID,TENPHONGBAN,DELETED,STT,MA) values (48,'3fdgrdfgdfg',1,0,null);
Insert into THUEKENH.PHONGBAN (ID,TENPHONGBAN,DELETED,STT,MA) values (49,'sdfgsdfgsdfg',1,0,null);
Insert into THUEKENH.PHONGBAN (ID,TENPHONGBAN,DELETED,STT,MA) values (50,'gregrwergwergwerg',1,0,null);
Insert into THUEKENH.PHONGBAN (ID,TENPHONGBAN,DELETED,STT,MA) values (51,'sdfgsdfgsdfg',1,0,null);
Insert into THUEKENH.PHONGBAN (ID,TENPHONGBAN,DELETED,STT,MA) values (52,'minhduc',1,0,null);
Insert into THUEKENH.PHONGBAN (ID,TENPHONGBAN,DELETED,STT,MA) values (84,'Phòng KTKT',0,2,null);
Insert into THUEKENH.PHONGBAN (ID,TENPHONGBAN,DELETED,STT,MA) values (85,'qwer',1,12,null);
Insert into THUEKENH.PHONGBAN (ID,TENPHONGBAN,DELETED,STT,MA) values (91,'abc2434',1,0,null);
Insert into THUEKENH.PHONGBAN (ID,TENPHONGBAN,DELETED,STT,MA) values (105,'WSFGWERGWE',1,4,null);
Insert into THUEKENH.PHONGBAN (ID,TENPHONGBAN,DELETED,STT,MA) values (124,'abcasdfasfd',0,34,null);
Insert into THUEKENH.PHONGBAN (ID,TENPHONGBAN,DELETED,STT,MA) values (189,'asdfasdfasdf',0,45,'asdfasdf');
Insert into THUEKENH.PHONGBAN (ID,TENPHONGBAN,DELETED,STT,MA) values (190,'sdf',1,0,null);
Insert into THUEKENH.PHONGBAN (ID,TENPHONGBAN,DELETED,STT,MA) values (191,'phong ',0,10,null);
Insert into THUEKENH.PHONGBAN (ID,TENPHONGBAN,DELETED,STT,MA) values (199,'phong cui bap4',0,5,null);
Insert into THUEKENH.PHONGBAN (ID,TENPHONGBAN,DELETED,STT,MA) values (200,'ten 1',0,2,null);
Insert into THUEKENH.PHONGBAN (ID,TENPHONGBAN,DELETED,STT,MA) values (1,'abcasdfasdfasdfasdf',1,null,null);
Insert into THUEKENH.PHONGBAN (ID,TENPHONGBAN,DELETED,STT,MA) values (2,'Đài điều hành',0,2,null);
Insert into THUEKENH.PHONGBAN (ID,TENPHONGBAN,DELETED,STT,MA) values (3,'Đài viễn thông',0,66,'ma2');
Insert into THUEKENH.PHONGBAN (ID,TENPHONGBAN,DELETED,STT,MA) values (6,'qwerqwer',1,0,null);
Insert into THUEKENH.PHONGBAN (ID,TENPHONGBAN,DELETED,STT,MA) values (7,'haha',1,0,null);
Insert into THUEKENH.PHONGBAN (ID,TENPHONGBAN,DELETED,STT,MA) values (8,'wdefwqef',1,0,null);
Insert into THUEKENH.PHONGBAN (ID,TENPHONGBAN,DELETED,STT,MA) values (9,'qwfqwef',1,0,null);
Insert into THUEKENH.PHONGBAN (ID,TENPHONGBAN,DELETED,STT,MA) values (10,'qwfqwef',1,0,null);
Insert into THUEKENH.PHONGBAN (ID,TENPHONGBAN,DELETED,STT,MA) values (11,'qwfqwef',1,0,null);
Insert into THUEKENH.PHONGBAN (ID,TENPHONGBAN,DELETED,STT,MA) values (12,'qwfqwef',1,0,null);
Insert into THUEKENH.PHONGBAN (ID,TENPHONGBAN,DELETED,STT,MA) values (13,'qwfqwef',1,0,null);
Insert into THUEKENH.PHONGBAN (ID,TENPHONGBAN,DELETED,STT,MA) values (14,'qwfqwef',1,0,null);
Insert into THUEKENH.PHONGBAN (ID,TENPHONGBAN,DELETED,STT,MA) values (15,'qwfqwef',1,0,null);
Insert into THUEKENH.PHONGBAN (ID,TENPHONGBAN,DELETED,STT,MA) values (16,'qwfqwef',1,0,null);
Insert into THUEKENH.PHONGBAN (ID,TENPHONGBAN,DELETED,STT,MA) values (17,'qwfqwef',1,0,null);
Insert into THUEKENH.PHONGBAN (ID,TENPHONGBAN,DELETED,STT,MA) values (88,'gdfgdfg',1,0,null);
Insert into THUEKENH.PHONGBAN (ID,TENPHONGBAN,DELETED,STT,MA) values (64,'Phòng KTKT',0,1,'ma11');
Insert into THUEKENH.PHONGBAN (ID,TENPHONGBAN,DELETED,STT,MA) values (65,'tieu chi',1,0,null);
Insert into THUEKENH.PHONGBAN (ID,TENPHONGBAN,DELETED,STT,MA) values (144,'phong1',1,0,'ma1');
REM INSERTING into THUEKENH.MENU
SET DEFINE OFF;
Insert into THUEKENH.MENU (ID,NAMEMENU,ACTION,ACTIVE,IDROOTMENU) values (24,'Loại giao tiếp','/danhmuc/loaigiaotiep.action',1,8);
Insert into THUEKENH.MENU (ID,NAMEMENU,ACTION,ACTIVE,IDROOTMENU) values (4,'Phòng ban','/danhmuc/phongban.action',1,8);
Insert into THUEKENH.MENU (ID,NAMEMENU,ACTION,ACTIVE,IDROOTMENU) values (2,'Quản trị nhóm','/group/index.action',1,7);
Insert into THUEKENH.MENU (ID,NAMEMENU,ACTION,ACTIVE,IDROOTMENU) values (3,'Quản trị quyền','/menu/index.action',1,7);
Insert into THUEKENH.MENU (ID,NAMEMENU,ACTION,ACTIVE,IDROOTMENU) values (1,'Quản trị user','/user/index.action',1,7);
Insert into THUEKENH.MENU (ID,NAMEMENU,ACTION,ACTIVE,IDROOTMENU) values (5,'Đối tác','/danhmuc/doitac.action',1,8);
Insert into THUEKENH.MENU (ID,NAMEMENU,ACTION,ACTIVE,IDROOTMENU) values (6,'Dự án','/danhmuc/duan.action',1,8);
Insert into THUEKENH.MENU (ID,NAMEMENU,ACTION,ACTIVE,IDROOTMENU) values (7,'Công thức','/danhmuc/congthuc.action',1,8);
Insert into THUEKENH.MENU (ID,NAMEMENU,ACTION,ACTIVE,IDROOTMENU) values (8,'Tiêu chuẩn bàn giao kênh','/danhmuc/tieuchuan.action',1,8);
Insert into THUEKENH.MENU (ID,NAMEMENU,ACTION,ACTIVE,IDROOTMENU) values (9,'Khu vực','/danhmuc/khuvuc.action',1,8);
Insert into THUEKENH.MENU (ID,NAMEMENU,ACTION,ACTIVE,IDROOTMENU) values (10,'Quản lý tuyến kênh','/tuyenkenh/index.action',1,1);
Insert into THUEKENH.MENU (ID,NAMEMENU,ACTION,ACTIVE,IDROOTMENU) values (11,'Import tuyến kênh','/import/tuyenkenh.action',1,1);
Insert into THUEKENH.MENU (ID,NAMEMENU,ACTION,ACTIVE,IDROOTMENU) values (12,'Quản lý tiến độ bàn giao kênh','/bangiao/index.action',1,1);
Insert into THUEKENH.MENU (ID,NAMEMENU,ACTION,ACTIVE,IDROOTMENU) values (13,'Quản lý văn bản đề xuất',null,1,3);
Insert into THUEKENH.MENU (ID,NAMEMENU,ACTION,ACTIVE,IDROOTMENU) values (14,'Quản lý biên bản bàn giao kênh',null,1,3);
Insert into THUEKENH.MENU (ID,NAMEMENU,ACTION,ACTIVE,IDROOTMENU) values (15,'Quản lý biên bản vận hành kênh',null,1,3);
Insert into THUEKENH.MENU (ID,NAMEMENU,ACTION,ACTIVE,IDROOTMENU) values (16,'Quản lý hợp đồng',null,1,4);
Insert into THUEKENH.MENU (ID,NAMEMENU,ACTION,ACTIVE,IDROOTMENU) values (17,'Quản lý phụ lục hợp đồng',null,1,4);
Insert into THUEKENH.MENU (ID,NAMEMENU,ACTION,ACTIVE,IDROOTMENU) values (18,'Báo cáo tiến độ',null,1,6);
Insert into THUEKENH.MENU (ID,NAMEMENU,ACTION,ACTIVE,IDROOTMENU) values (19,'Xuất bảng đối soát cước',null,1,6);
Insert into THUEKENH.MENU (ID,NAMEMENU,ACTION,ACTIVE,IDROOTMENU) values (20,'Báo cáo giảm trừ mất liên lạc',null,1,6);
Insert into THUEKENH.MENU (ID,NAMEMENU,ACTION,ACTIVE,IDROOTMENU) values (21,'Báo cáo sự cố theo thời gian',null,1,6);
Insert into THUEKENH.MENU (ID,NAMEMENU,ACTION,ACTIVE,IDROOTMENU) values (22,'SỰ CỐ KÊNH','/sucokenh/index.action',1,2);
Insert into THUEKENH.MENU (ID,NAMEMENU,ACTION,ACTIVE,IDROOTMENU) values (23,'QUẢN LÝ HỒ SƠ TT','/thanhtoan/index.action',1,5);
REM INSERTING into THUEKENH.USER_MENU
SET DEFINE OFF;
Insert into THUEKENH.USER_MENU (ACCOUNTID,MENUID) values (0,1);
Insert into THUEKENH.USER_MENU (ACCOUNTID,MENUID) values (0,2);
Insert into THUEKENH.USER_MENU (ACCOUNTID,MENUID) values (0,3);
Insert into THUEKENH.USER_MENU (ACCOUNTID,MENUID) values (0,4);
Insert into THUEKENH.USER_MENU (ACCOUNTID,MENUID) values (0,5);
Insert into THUEKENH.USER_MENU (ACCOUNTID,MENUID) values (0,6);
Insert into THUEKENH.USER_MENU (ACCOUNTID,MENUID) values (0,7);
Insert into THUEKENH.USER_MENU (ACCOUNTID,MENUID) values (0,8);
Insert into THUEKENH.USER_MENU (ACCOUNTID,MENUID) values (0,9);
Insert into THUEKENH.USER_MENU (ACCOUNTID,MENUID) values (0,10);
Insert into THUEKENH.USER_MENU (ACCOUNTID,MENUID) values (0,11);
Insert into THUEKENH.USER_MENU (ACCOUNTID,MENUID) values (0,24);
REM INSERTING into THUEKENH.TIEUCHUAN
SET DEFINE OFF;
Insert into THUEKENH.TIEUCHUAN (ID,TENTIEUCHUAN,LOAITIEUCHUAN,MOTA,USERCREATE,TIMECREATE,STT,DELETED,MA) values (1,'3',3,'3','adm',to_date('01-SEP-12','DD-MON-RR'),3,0,'3');
Insert into THUEKENH.TIEUCHUAN (ID,TENTIEUCHUAN,LOAITIEUCHUAN,MOTA,USERCREATE,TIMECREATE,STT,DELETED,MA) values (21,'1',1,'1',null,to_date('20-SEP-12','DD-MON-RR'),1,0,'1');
Insert into THUEKENH.TIEUCHUAN (ID,TENTIEUCHUAN,LOAITIEUCHUAN,MOTA,USERCREATE,TIMECREATE,STT,DELETED,MA) values (22,'1',1,null,null,to_date('20-SEP-12','DD-MON-RR'),0,0,null);
Insert into THUEKENH.TIEUCHUAN (ID,TENTIEUCHUAN,LOAITIEUCHUAN,MOTA,USERCREATE,TIMECREATE,STT,DELETED,MA) values (2,'tentieuchuan_',1,'mota_','admin',to_date('19-SEP-12','DD-MON-RR'),1,0,'1');
Insert into THUEKENH.TIEUCHUAN (ID,TENTIEUCHUAN,LOAITIEUCHUAN,MOTA,USERCREATE,TIMECREATE,STT,DELETED,MA) values (3,'0',0,'0','admin',to_date('19-SEP-12','DD-MON-RR'),0,0,'0');
REM INSERTING into THUEKENH.CONGTHUC
SET DEFINE OFF;
Insert into THUEKENH.CONGTHUC (ID,TENCONGTHUC,CHUOICONGTHUC,USERCREATE,TIMECREATE,STT,DELETED,MA) values (1,'name_','congthuc_','admin',to_date('11-SEP-12','DD-MON-RR'),0,1,'1');
Insert into THUEKENH.CONGTHUC (ID,TENCONGTHUC,CHUOICONGTHUC,USERCREATE,TIMECREATE,STT,DELETED,MA) values (21,'cong thúc 1','chuoi 3','admin',to_date('19-SEP-12','DD-MON-RR'),3,0,'ma 1');
--------------------------------------------------------
--  DDL for Index SYS_C0012193
--------------------------------------------------------

  CREATE UNIQUE INDEX "THUEKENH"."SYS_C0012193" ON "THUEKENH"."DOITAC" ("ID") 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1 BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
  TABLESPACE "USERS" ;
--------------------------------------------------------
--  DDL for Index DOITAC_INDEX1
--------------------------------------------------------

  CREATE UNIQUE INDEX "THUEKENH"."DOITAC_INDEX1" ON "THUEKENH"."DOITAC" ("TENDOITAC") 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1 BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
  TABLESPACE "USERS" ;
--------------------------------------------------------
--  DDL for Index SYS_C0012196
--------------------------------------------------------

  CREATE UNIQUE INDEX "THUEKENH"."SYS_C0012196" ON "THUEKENH"."DUAN" ("ID") 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1 BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
  TABLESPACE "USERS" ;
--------------------------------------------------------
--  DDL for Index KHUVUC _PK
--------------------------------------------------------

  CREATE UNIQUE INDEX "THUEKENH"."KHUVUC _PK" ON "THUEKENH"."KHUVUC" ("ID") 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1 BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
  TABLESPACE "USERS" ;
--------------------------------------------------------
--  DDL for Index KHUVUC_INDEX1
--------------------------------------------------------

  CREATE UNIQUE INDEX "THUEKENH"."KHUVUC_INDEX1" ON "THUEKENH"."KHUVUC" ("TENKHUVUC") 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1 BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
  TABLESPACE "USERS" ;
--------------------------------------------------------
--  DDL for Index PHONGBAN _PK
--------------------------------------------------------

  CREATE UNIQUE INDEX "THUEKENH"."PHONGBAN _PK" ON "THUEKENH"."PHONGBAN" ("ID") 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1 BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
  TABLESPACE "USERS" ;
--------------------------------------------------------
--  DDL for Index PHONGBAN_INDEX1
--------------------------------------------------------

  CREATE UNIQUE INDEX "THUEKENH"."PHONGBAN_INDEX1" ON "THUEKENH"."PHONGBAN" ("MA") 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1 BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
  TABLESPACE "USERS" ;
--------------------------------------------------------
--  DDL for Index MENU_PK
--------------------------------------------------------

  CREATE UNIQUE INDEX "THUEKENH"."MENU_PK" ON "THUEKENH"."MENU" ("ID") 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1 BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
  TABLESPACE "USERS" ;
--------------------------------------------------------
--  DDL for Index USER_MENU_PK
--------------------------------------------------------

  CREATE UNIQUE INDEX "THUEKENH"."USER_MENU_PK" ON "THUEKENH"."USER_MENU" ("ACCOUNTID", "MENUID") 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1 BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
  TABLESPACE "USERS" ;
--------------------------------------------------------
--  DDL for Index TIEUCHUAN_PK
--------------------------------------------------------

  CREATE UNIQUE INDEX "THUEKENH"."TIEUCHUAN_PK" ON "THUEKENH"."TIEUCHUAN" ("ID") 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1 BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
  TABLESPACE "USERS" ;
--------------------------------------------------------
--  DDL for Index CONGTHUC_INDEX1
--------------------------------------------------------

  CREATE UNIQUE INDEX "THUEKENH"."CONGTHUC_INDEX1" ON "THUEKENH"."CONGTHUC" ("TENCONGTHUC") 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1 BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
  TABLESPACE "USERS" ;
--------------------------------------------------------
--  DDL for Index CONGTHUC_PK
--------------------------------------------------------

  CREATE UNIQUE INDEX "THUEKENH"."CONGTHUC_PK" ON "THUEKENH"."CONGTHUC" ("ID") 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1 BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
  TABLESPACE "USERS" ;
--------------------------------------------------------
--  Constraints for Table DOITAC
--------------------------------------------------------

  ALTER TABLE "THUEKENH"."DOITAC" MODIFY ("ID" NOT NULL ENABLE);
 
  ALTER TABLE "THUEKENH"."DOITAC" ADD PRIMARY KEY ("ID")
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1 BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
  TABLESPACE "USERS"  ENABLE;
 
  ALTER TABLE "THUEKENH"."DOITAC" ADD CHECK ("ID" IS NOT NULL) ENABLE;
--------------------------------------------------------
--  Constraints for Table DUAN
--------------------------------------------------------

  ALTER TABLE "THUEKENH"."DUAN" MODIFY ("ID" NOT NULL ENABLE);
 
  ALTER TABLE "THUEKENH"."DUAN" ADD PRIMARY KEY ("ID")
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1 BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
  TABLESPACE "USERS"  ENABLE;
 
  ALTER TABLE "THUEKENH"."DUAN" ADD CHECK ("ID" IS NOT NULL) ENABLE;
 
  ALTER TABLE "THUEKENH"."DUAN" ADD CHECK ("ID" IS NOT NULL) ENABLE;
--------------------------------------------------------
--  Constraints for Table KHUVUC
--------------------------------------------------------

  ALTER TABLE "THUEKENH"."KHUVUC" ADD CONSTRAINT "KHUVUC _PK" PRIMARY KEY ("ID")
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1 BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
  TABLESPACE "USERS"  ENABLE;
 
  ALTER TABLE "THUEKENH"."KHUVUC" MODIFY ("ID" NOT NULL ENABLE);
--------------------------------------------------------
--  Constraints for Table PHONGBAN
--------------------------------------------------------

  ALTER TABLE "THUEKENH"."PHONGBAN" ADD CONSTRAINT "PHONGBAN _PK" PRIMARY KEY ("ID")
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1 BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
  TABLESPACE "USERS"  ENABLE;
 
  ALTER TABLE "THUEKENH"."PHONGBAN" MODIFY ("ID" NOT NULL ENABLE);
--------------------------------------------------------
--  Constraints for Table MENU
--------------------------------------------------------

  ALTER TABLE "THUEKENH"."MENU" ADD CONSTRAINT "MENU_PK" PRIMARY KEY ("ID")
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1 BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
  TABLESPACE "USERS"  ENABLE;
 
  ALTER TABLE "THUEKENH"."MENU" MODIFY ("ID" NOT NULL ENABLE);
--------------------------------------------------------
--  Constraints for Table USER_MENU
--------------------------------------------------------

  ALTER TABLE "THUEKENH"."USER_MENU" MODIFY ("ACCOUNTID" NOT NULL ENABLE);
 
  ALTER TABLE "THUEKENH"."USER_MENU" MODIFY ("MENUID" NOT NULL ENABLE);
 
  ALTER TABLE "THUEKENH"."USER_MENU" ADD CONSTRAINT "USER_MENU_PK" PRIMARY KEY ("ACCOUNTID", "MENUID")
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1 BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
  TABLESPACE "USERS"  ENABLE;
--------------------------------------------------------
--  Constraints for Table TIEUCHUAN
--------------------------------------------------------

  ALTER TABLE "THUEKENH"."TIEUCHUAN" MODIFY ("ID" NOT NULL ENABLE);
 
  ALTER TABLE "THUEKENH"."TIEUCHUAN" ADD CONSTRAINT "TIEUCHUAN_PK" PRIMARY KEY ("ID")
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1 BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
  TABLESPACE "USERS"  ENABLE;
--------------------------------------------------------
--  Constraints for Table CONGTHUC
--------------------------------------------------------

  ALTER TABLE "THUEKENH"."CONGTHUC" ADD CONSTRAINT "CONGTHUC_PK" PRIMARY KEY ("ID")
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1 BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
  TABLESPACE "USERS"  ENABLE;
 
  ALTER TABLE "THUEKENH"."CONGTHUC" MODIFY ("ID" NOT NULL ENABLE);




  --------------------------------------------------------
--  File created - Thursday-September-20-2012   
--------------------------------------------------------
--------------------------------------------------------
--  DDL for Sequence SEQ_CONGTHUC
--------------------------------------------------------

   CREATE SEQUENCE  "THUEKENH"."SEQ_CONGTHUC"  MINVALUE 1 MAXVALUE 999999999 INCREMENT BY 1 START WITH 41 CACHE 20 NOORDER  NOCYCLE ;
--------------------------------------------------------
--  DDL for Sequence SEQ_DOITAC
--------------------------------------------------------

   CREATE SEQUENCE  "THUEKENH"."SEQ_DOITAC"  MINVALUE 1 MAXVALUE 9999999 INCREMENT BY 1 START WITH 101 CACHE 20 NOORDER  NOCYCLE ;
--------------------------------------------------------
--  DDL for Sequence SEQ_DUAN
--------------------------------------------------------

   CREATE SEQUENCE  "THUEKENH"."SEQ_DUAN"  MINVALUE 1 MAXVALUE 99999999 INCREMENT BY 1 START WITH 62 CACHE 20 NOORDER  NOCYCLE ;
--------------------------------------------------------
--  DDL for Sequence SEQ_KHUVUC
--------------------------------------------------------

   CREATE SEQUENCE  "THUEKENH"."SEQ_KHUVUC"  MINVALUE 1 MAXVALUE 99999999 INCREMENT BY 1 START WITH 6 CACHE 20 NOORDER  NOCYCLE ;
--------------------------------------------------------
--  DDL for Sequence SEQ_LOAIGIAOTIEP
--------------------------------------------------------

   CREATE SEQUENCE  "THUEKENH"."SEQ_LOAIGIAOTIEP"  MINVALUE 1 MAXVALUE 999999 INCREMENT BY 1 START WITH 101 CACHE 20 NOORDER  NOCYCLE ;
--------------------------------------------------------
--  DDL for Sequence SEQ_PHONGBAN
--------------------------------------------------------

   CREATE SEQUENCE  "THUEKENH"."SEQ_PHONGBAN"  MINVALUE 1 MAXVALUE 999999999 INCREMENT BY 1 START WITH 204 CACHE 20 NOORDER  NOCYCLE ;
--------------------------------------------------------
--  DDL for Sequence SEQ_TIEUCHUAN
--------------------------------------------------------

   CREATE SEQUENCE  "THUEKENH"."SEQ_TIEUCHUAN"  MINVALUE 1 MAXVALUE 99999999 INCREMENT BY 1 START WITH 41 CACHE 20 NOORDER  NOCYCLE ;





--------------------------------------------------------
--  File created - Thursday-September-20-2012   
--------------------------------------------------------
--------------------------------------------------------
--  DDL for Procedure PROC_SAVE_CONGTHUC
--------------------------------------------------------
set define off;

  CREATE OR REPLACE PROCEDURE "THUEKENH"."PROC_SAVE_CONGTHUC" (
  id_	in number,
	name_ in VARCHAR2,
  congthuc_ in VARCHAR2,
	usercreate_ in VARCHAR2,
  stt_ IN number,
  deleted_ IN number,
  ma_ in varchar2
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
        ma=ma_
        where ID = id_;
    else --insert
    --i=n insert
      i:=SEQ_CONGTHUC.nextval;
      insert into CONGTHUC(ID,TENCONGTHUC,CHUOICONGTHUC,TIMECREATE,USERCREATE,STT,DELETED,MA)
      VALUES(i,name_,congthuc_,sysdate,usercreate_,stt_,deleted_,ma_);
    end if;

END PROC_SAVE_CONGTHUC;

/
--------------------------------------------------------
--  DDL for Procedure PROC_SAVE_DOITAC
--------------------------------------------------------
set define off;

  CREATE OR REPLACE PROCEDURE "THUEKENH"."PROC_SAVE_DOITAC" (
  id_	in nvarchar2,
	name_ in VARCHAR2,
	stt_ IN number,
  deleted_ IN number,
  ma_ in nvarchar2
) AS 
i INTEGER := 0;
BEGIN
		if(id_ is not null and id_>0) then --update
      update DOITAC set TENDOITAC = name_,Ma=ma_ where ID = id_;
	else --insert
		i:=SEQ_DOITAC.nextval;
		insert into DOITAC(ID,TENDOITAC,DELETED,STT,MA) values (i,name_,deleted_,stt_,ma_);
  end if;
END PROC_SAVE_DOITAC;

/
--------------------------------------------------------
--  DDL for Procedure PROC_SAVE_DUAN
--------------------------------------------------------
set define off;

  CREATE OR REPLACE PROCEDURE "THUEKENH"."PROC_SAVE_DUAN" (
  id_	in nvarchar2,
	name_ in VARCHAR2,
	stt_ IN number,
  deleted_ IN number,
  mota_ in nvarchar2,
  giamgia_ in number,
  usercreate_ in varchar2,
  ma_ in varchar2
) AS 
i INTEGER := 0;
BEGIN
		i:=SEQ_DUAN.nextval;
		insert into DUAN(ID,TENDUAN,DELETED,STT,MOTA,GIAMGIA,USERCREATE,TIMECREATE,MA) values (i,name_,deleted_,stt_,mota_,giamgia_,usercreate_,sysdate,ma_);
END PROC_SAVE_DUAN;

/
--------------------------------------------------------
--  DDL for Procedure PROC_SAVE_KHUVUC
--------------------------------------------------------
set define off;

  CREATE OR REPLACE PROCEDURE "THUEKENH"."PROC_SAVE_KHUVUC" (
  id_	in nvarchar2,
	name_ in VARCHAR2,
	stt_ IN number,
  deleted_ IN number,
  ma_ in varchar2
) AS 
i INTEGER := 0;
BEGIN
		if(id_ is not null and id_>0) then --update
      update KHUVUC set TENKHUVUC = name_ where ID = id_;
	else --insert
		i:=SEQ_PHONGBAN.nextval;
		insert into KHUVUC(ID,TENKHUVUC,DELETED,STT,MA) values (i,name_,deleted_,stt_,ma_);
  end if;
END PROC_SAVE_KHUVUC;

/
--------------------------------------------------------
--  DDL for Procedure PROC_SAVE_LOAIGIAOTIEP
--------------------------------------------------------
set define off;

  CREATE OR REPLACE PROCEDURE "THUEKENH"."PROC_SAVE_LOAIGIAOTIEP" (
  id_	in number,
	name_ in VARCHAR2,
	cuoccong_ IN number,
  deleted_ IN number,
  ma_ in varchar2,
  stt_ in number
) AS 
i INTEGER := 0;
BEGIN

    --i=0 update
      if(id_ is not null and id_>0) then --update
        update LOAIGIAOTIEP set LOAIGIAOTIEP = name_,CUOCCONG=cuoccong_,Ma=ma_,STT=stt_ where ID = id_;
    else --insert
    --i=n insert
      i:=SEQ_LOAIGIAOTIEP.nextval;
      insert into LOAIGIAOTIEP(ID,LOAIGIAOTIEP,DELETED,CUOCCONG,MA,STT) values (i,name_,deleted_,cuoccong_,ma_,stt_);
    end if;

END PROC_SAVE_LOAIGIAOTIEP;

/
--------------------------------------------------------
--  DDL for Procedure PROC_SAVE_PHONGBAN
--------------------------------------------------------
set define off;

  CREATE OR REPLACE PROCEDURE "THUEKENH"."PROC_SAVE_PHONGBAN" (
  id_	in nvarchar2,
	name_ in VARCHAR2,
	stt_ IN number,
  deleted_ IN number,
  ma_ in VARCHAR2
) AS 
i INTEGER := 0;
BEGIN
		i:=SEQ_PHONGBAN.nextval;
		insert into PHONGBAN(ID,TENPHONGBAN,DELETED,STT,MA) values (i,name_,deleted_,stt_,ma_);
END PROC_SAVE_PHONGBAN;

/
--------------------------------------------------------
--  DDL for Procedure PROC_SAVE_TIEUCHUAN
--------------------------------------------------------
set define off;

  CREATE OR REPLACE PROCEDURE "THUEKENH"."PROC_SAVE_TIEUCHUAN" (
id_ in varchar2,
tentieuchuan_ in varchar2,
loaitieuchuan_ in number,
mota_ in varchar2,
usercreate_ in varchar2,
stt_ in number,
deleted_ in number,
ma_ in varchar2
) AS 
i INTEGER := 0;
BEGIN
    --i=n insert
      i:=SEQ_TIEUCHUAN.nextval;
      insert into TIEUCHUAN(id,tentieuchuan,loaitieuchuan,mota,usercreate,timecreate,stt,deleted,ma) 
      values (i,tentieuchuan_,loaitieuchuan_,mota_,usercreate_,sysdate,stt_,deleted_,ma_);

END PROC_SAVE_TIEUCHUAN;

/
