--------------------------------------------------------
--  File created - Saturday-December-21-2013   
--------------------------------------------------------
--------------------------------------------------------
--  DDL for Table V_STS_SYS_USER_AREA
--------------------------------------------------------

  CREATE TABLE "V_STS_SYS_USER_AREA" 
   (	"USERNAME" VARCHAR2(100 BYTE), 
	"DISTRICT" VARCHAR2(100 BYTE), 
	"DESCRIPTION" VARCHAR2(500 BYTE), 
	"IS_ENABLE" VARCHAR2(5 BYTE), 
	"ORDERING" VARCHAR2(20 BYTE), 
	"ALARM_KPI" VARCHAR2(20 BYTE), 
	"ID" VARCHAR2(20 BYTE)
   ) ;
REM INSERTING into V_STS_SYS_USER_AREA
Insert into V_STS_SYS_USER_AREA (USERNAME,DISTRICT,DESCRIPTION,IS_ENABLE,ORDERING,ALARM_KPI,ID) values ('admin','DNVC',null,null,null,null,null);
Insert into V_STS_SYS_USER_AREA (USERNAME,DISTRICT,DESCRIPTION,IS_ENABLE,ORDERING,ALARM_KPI,ID) values ('admin','VUVT',null,null,null,null,null);
Insert into V_STS_SYS_USER_AREA (USERNAME,DISTRICT,DESCRIPTION,IS_ENABLE,ORDERING,ALARM_KPI,ID) values ('ktkt','NTPR',null,null,null,null,null);
Insert into V_STS_SYS_USER_AREA (USERNAME,DISTRICT,DESCRIPTION,IS_ENABLE,ORDERING,ALARM_KPI,ID) values ('langlv','VUTT',null,null,null,null,null);
Insert into V_STS_SYS_USER_AREA (USERNAME,DISTRICT,DESCRIPTION,IS_ENABLE,ORDERING,ALARM_KPI,ID) values ('langlv','BPBL',null,null,null,null,null);
Insert into V_STS_SYS_USER_AREA (USERNAME,DISTRICT,DESCRIPTION,IS_ENABLE,ORDERING,ALARM_KPI,ID) values ('xuanhn','LATA',null,null,null,null,null);
Insert into V_STS_SYS_USER_AREA (USERNAME,DISTRICT,DESCRIPTION,IS_ENABLE,ORDERING,ALARM_KPI,ID) values ('duongtb','LACG',null,null,null,null,null);


CREATE TABLE V_STS_SYS_USER_AREA 
(
  USERNAME VARCHAR2(200) 
, DISTRICT VARCHAR2(200) 
, DESCRIPTION VARCHAR2(200) 
, IS_ENABLE VARCHAR2(20) 
, ORDERING VARCHAR2(20) 
, ALARM_KPI VARCHAR2(20) 
, ID VARCHAR2(20) 
, CODE VARCHAR2(20) 
, CREATE_DATE VARCHAR2(100) 
);
