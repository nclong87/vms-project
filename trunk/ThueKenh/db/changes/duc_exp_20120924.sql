--------------------------------------------------------
--  File created - Monday-September-24-2012   
--------------------------------------------------------
  DROP TABLE "THUEKENH"."DOITAC";
  DROP TABLE "THUEKENH"."CONGTHUC";
  DROP TABLE "THUEKENH"."DUAN";
  DROP TABLE "THUEKENH"."KHUVUC";
  DROP TABLE "THUEKENH"."LOAIGIAOTIEP";
  DROP TABLE "THUEKENH"."PHONGBAN";
  DROP TABLE "THUEKENH"."TIEUCHUAN";
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
--  DDL for Table LOAIGIAOTIEP
--------------------------------------------------------

  CREATE TABLE "THUEKENH"."LOAIGIAOTIEP" 
   (	"ID" NUMBER, 
	"LOAIGIAOTIEP" VARCHAR2(200 BYTE), 
	"CUOCCONG" NUMBER, 
	"DELETED" NUMBER(1,0), 
	"MA" VARCHAR2(20 BYTE), 
	"STT" NUMBER
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
REM INSERTING into THUEKENH.CONGTHUC
SET DEFINE OFF;
Insert into THUEKENH.CONGTHUC (ID,TENCONGTHUC,CHUOICONGTHUC,USERCREATE,TIMECREATE,STT,DELETED,MA) values (1,'name_','congthuc_','admin',to_date('11-SEP-12','DD-MON-RR'),0,1,'1');
Insert into THUEKENH.CONGTHUC (ID,TENCONGTHUC,CHUOICONGTHUC,USERCREATE,TIMECREATE,STT,DELETED,MA) values (21,'cong thúc 1','chuoi 3','admin',to_date('19-SEP-12','DD-MON-RR'),3,0,'ma 1');
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
REM INSERTING into THUEKENH.LOAIGIAOTIEP
SET DEFINE OFF;
Insert into THUEKENH.LOAIGIAOTIEP (ID,LOAIGIAOTIEP,CUOCCONG,DELETED,MA,STT) values (2,'dfdfdf1',0,1,null,null);
Insert into THUEKENH.LOAIGIAOTIEP (ID,LOAIGIAOTIEP,CUOCCONG,DELETED,MA,STT) values (3,'1212312',0,1,null,null);
Insert into THUEKENH.LOAIGIAOTIEP (ID,LOAIGIAOTIEP,CUOCCONG,DELETED,MA,STT) values (9,'abc1233434',1,1,'ma',1);
Insert into THUEKENH.LOAIGIAOTIEP (ID,LOAIGIAOTIEP,CUOCCONG,DELETED,MA,STT) values (21,'12344',0,1,null,null);
Insert into THUEKENH.LOAIGIAOTIEP (ID,LOAIGIAOTIEP,CUOCCONG,DELETED,MA,STT) values (22,'dfasdf',0,0,null,0);
Insert into THUEKENH.LOAIGIAOTIEP (ID,LOAIGIAOTIEP,CUOCCONG,DELETED,MA,STT) values (23,'1',1,0,'1',1);
Insert into THUEKENH.LOAIGIAOTIEP (ID,LOAIGIAOTIEP,CUOCCONG,DELETED,MA,STT) values (26,'cuoc',0,0,null,null);
Insert into THUEKENH.LOAIGIAOTIEP (ID,LOAIGIAOTIEP,CUOCCONG,DELETED,MA,STT) values (28,'aaaa1',0,0,null,null);
Insert into THUEKENH.LOAIGIAOTIEP (ID,LOAIGIAOTIEP,CUOCCONG,DELETED,MA,STT) values (61,'loai 1',1,0,'ma 1',null);
Insert into THUEKENH.LOAIGIAOTIEP (ID,LOAIGIAOTIEP,CUOCCONG,DELETED,MA,STT) values (81,'2',2,0,'2',2);
Insert into THUEKENH.LOAIGIAOTIEP (ID,LOAIGIAOTIEP,CUOCCONG,DELETED,MA,STT) values (27,'acvefffff',10012,0,null,null);
Insert into THUEKENH.LOAIGIAOTIEP (ID,LOAIGIAOTIEP,CUOCCONG,DELETED,MA,STT) values (41,'5T5T545',544,0,null,null);
Insert into THUEKENH.LOAIGIAOTIEP (ID,LOAIGIAOTIEP,CUOCCONG,DELETED,MA,STT) values (1,'abc123',0,1,null,null);
Insert into THUEKENH.LOAIGIAOTIEP (ID,LOAIGIAOTIEP,CUOCCONG,DELETED,MA,STT) values (8,'abc123123',0,0,null,null);
Insert into THUEKENH.LOAIGIAOTIEP (ID,LOAIGIAOTIEP,CUOCCONG,DELETED,MA,STT) values (4,'q123333',0,1,null,null);
Insert into THUEKENH.LOAIGIAOTIEP (ID,LOAIGIAOTIEP,CUOCCONG,DELETED,MA,STT) values (5,'11234555',0,1,null,null);
Insert into THUEKENH.LOAIGIAOTIEP (ID,LOAIGIAOTIEP,CUOCCONG,DELETED,MA,STT) values (6,'tjhrtherthe',0,1,null,null);
Insert into THUEKENH.LOAIGIAOTIEP (ID,LOAIGIAOTIEP,CUOCCONG,DELETED,MA,STT) values (24,'cuoccong',0,0,null,null);
Insert into THUEKENH.LOAIGIAOTIEP (ID,LOAIGIAOTIEP,CUOCCONG,DELETED,MA,STT) values (25,'cuoc',0,0,null,null);
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
Insert into THUEKENH.PHONGBAN (ID,TENPHONGBAN,DELETED,STT,MA) values (204,'kjhjh',0,1,'pq');
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
REM INSERTING into THUEKENH.TIEUCHUAN
SET DEFINE OFF;
Insert into THUEKENH.TIEUCHUAN (ID,TENTIEUCHUAN,LOAITIEUCHUAN,MOTA,USERCREATE,TIMECREATE,STT,DELETED,MA) values (1,'3',3,'3','adm',to_date('01-SEP-12','DD-MON-RR'),3,0,'3');
Insert into THUEKENH.TIEUCHUAN (ID,TENTIEUCHUAN,LOAITIEUCHUAN,MOTA,USERCREATE,TIMECREATE,STT,DELETED,MA) values (21,'1',1,'1',null,to_date('20-SEP-12','DD-MON-RR'),1,0,'1');
Insert into THUEKENH.TIEUCHUAN (ID,TENTIEUCHUAN,LOAITIEUCHUAN,MOTA,USERCREATE,TIMECREATE,STT,DELETED,MA) values (22,'1',1,null,null,to_date('20-SEP-12','DD-MON-RR'),0,0,null);
Insert into THUEKENH.TIEUCHUAN (ID,TENTIEUCHUAN,LOAITIEUCHUAN,MOTA,USERCREATE,TIMECREATE,STT,DELETED,MA) values (2,'tentieuchuan_',1,'mota_','admin',to_date('19-SEP-12','DD-MON-RR'),1,0,'1');
Insert into THUEKENH.TIEUCHUAN (ID,TENTIEUCHUAN,LOAITIEUCHUAN,MOTA,USERCREATE,TIMECREATE,STT,DELETED,MA) values (3,'0',0,'0','admin',to_date('19-SEP-12','DD-MON-RR'),0,0,'0');
--------------------------------------------------------
--  DDL for Index DOITAC_INDEX1
--------------------------------------------------------

  CREATE UNIQUE INDEX "THUEKENH"."DOITAC_INDEX1" ON "THUEKENH"."DOITAC" ("TENDOITAC") 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1 BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
  TABLESPACE "USERS" ;
--------------------------------------------------------
--  DDL for Index SYS_C0012553
--------------------------------------------------------

  CREATE UNIQUE INDEX "THUEKENH"."SYS_C0012553" ON "THUEKENH"."DOITAC" ("ID") 
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
--  DDL for Index CONGTHUC_INDEX1
--------------------------------------------------------

  CREATE UNIQUE INDEX "THUEKENH"."CONGTHUC_INDEX1" ON "THUEKENH"."CONGTHUC" ("TENCONGTHUC") 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1 BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
  TABLESPACE "USERS" ;
--------------------------------------------------------
--  DDL for Index SYS_C0012556
--------------------------------------------------------

  CREATE UNIQUE INDEX "THUEKENH"."SYS_C0012556" ON "THUEKENH"."DUAN" ("ID") 
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
--  DDL for Index LOAIGIAOTIEP_PK
--------------------------------------------------------

  CREATE UNIQUE INDEX "THUEKENH"."LOAIGIAOTIEP_PK" ON "THUEKENH"."LOAIGIAOTIEP" ("ID") 
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
--  DDL for Index TIEUCHUAN_PK
--------------------------------------------------------

  CREATE UNIQUE INDEX "THUEKENH"."TIEUCHUAN_PK" ON "THUEKENH"."TIEUCHUAN" ("ID") 
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
--  Constraints for Table CONGTHUC
--------------------------------------------------------

  ALTER TABLE "THUEKENH"."CONGTHUC" ADD CONSTRAINT "CONGTHUC_PK" PRIMARY KEY ("ID")
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1 BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
  TABLESPACE "USERS"  ENABLE;
 
  ALTER TABLE "THUEKENH"."CONGTHUC" MODIFY ("ID" NOT NULL ENABLE);
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
--  Constraints for Table LOAIGIAOTIEP
--------------------------------------------------------

  ALTER TABLE "THUEKENH"."LOAIGIAOTIEP" ADD CONSTRAINT "LOAIGIAOTIEP_PK" PRIMARY KEY ("ID")
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1 BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
  TABLESPACE "USERS"  ENABLE;
 
  ALTER TABLE "THUEKENH"."LOAIGIAOTIEP" MODIFY ("ID" NOT NULL ENABLE);
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
--  Constraints for Table TIEUCHUAN
--------------------------------------------------------

  ALTER TABLE "THUEKENH"."TIEUCHUAN" MODIFY ("ID" NOT NULL ENABLE);
 
  ALTER TABLE "THUEKENH"."TIEUCHUAN" ADD CONSTRAINT "TIEUCHUAN_PK" PRIMARY KEY ("ID")
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1 BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
  TABLESPACE "USERS"  ENABLE;







