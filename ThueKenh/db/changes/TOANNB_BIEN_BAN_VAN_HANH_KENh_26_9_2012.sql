--------------------------------------------------------
--  DDL for Table BIENBANVANHANH
--------------------------------------------------------

  CREATE OR REPLACE TABLE "THUEKENH"."BIENBANVANHANH" 
   (	"ID" NUMBER, 
	"SOBIENBAN" VARCHAR2(200 BYTE), 
	"USERCREATE" VARCHAR2(200 BYTE), 
	"TIMECREATE" DATE, 
	"DELETED" NUMBER(1,0), 
	"FILENAME" VARCHAR2(200 BYTE), 
	"FILEPATH" VARCHAR2(200 BYTE), 
	"FILESIZE" NUMBER
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 NOCOMPRESS LOGGING
  STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1 BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
  TABLESPACE "USERS" ;
--------------------------------------------------------
--  DDL for Index BIENBANVANHANH_PK
--------------------------------------------------------

  CREATE UNIQUE INDEX "THUEKENH"."BIENBANVANHANH_PK" ON "THUEKENH"."BIENBANVANHANH" ("ID") 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1 BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
  TABLESPACE "USERS" ;
--------------------------------------------------------
--  Constraints for Table BIENBANVANHANH
--------------------------------------------------------

  ALTER TABLE "THUEKENH"."BIENBANVANHANH" ADD CONSTRAINT "BIENBANVANHANH_PK" PRIMARY KEY ("ID")
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1 BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
  TABLESPACE "USERS"  ENABLE;
 
  ALTER TABLE "THUEKENH"."BIENBANVANHANH" MODIFY ("ID" NOT NULL ENABLE);

  --------------------------------------------------------
--  DDL for Function FN_FIND_BIENBANVANHANHKENH
--------------------------------------------------------

  CREATE OR REPLACE FUNCTION "THUEKENH"."FN_FIND_BIENBANVANHANHKENH" 
(
  iDisplayStart IN NUMBER,   
  iDisplayLength IN NUMBER, 
  sobienban_ in varchar2
) 
RETURN SYS_REFCURSOR AS l_cursor SYS_REFCURSOR;
v_vcsql VARCHAR2(2000);
v_vcsqlwhere VARCHAR2(1000);
i NUMBER;
BEGIN
	v_vcsqlwhere := ' DELETED = 0 ';
	if(sobienban_ is not null) then
		v_vcsqlwhere := v_vcsqlwhere ||' AND SOBIENBAN = '''||sobienban_||''' ';
	end if;
	v_vcsql := 'select rownum as rn,dulieu.* from (SELECT *
                                                 FROM BIENBANVANHANH   
                                                 WHERE ' || v_vcsqlwhere || ' ORDER BY TIMECREATE desc) dulieu ';
	v_vcsql := 'SELECT * FROM (' || v_vcsql || ') WHERE rn >= ' || iDisplayStart || ' and rn <= ' || (iDisplayStart+iDisplayLength);
	--dbms_output.put_line(v_vcsql);
  --test(v_vcsql);
	OPEN l_cursor FOR v_vcsql;
	RETURN l_cursor;
END FN_FIND_BIENBANVANHANHKENH;

/

--------------------------------------------------------
--  DDL for Function SAVE_BIENBANVANHANH
--------------------------------------------------------

  CREATE OR REPLACE FUNCTION "THUEKENH"."SAVE_BIENBANVANHANH" 
(
  id_ in varchar2,
  sobienban_ in varchar2,
  usercreate_ in varchar2,
  timecreate_ in varchar2,
  deleted_ in varchar2,
  filename_ in varchar2,
  filepath_ in varchar2,
  filesize_ in varchar2
)
RETURN NUMBER AS i INTEGER :=0; 
BEGIN
  IF(id_ IS NOT NULL AND id_ >0) THEN --update
    UPDATE BIENBANVANHANH 
    SET 
        SOBIENBAN= sobienban_, 
        USERCREATE= usercreate_,
        TIMECREATE= timecreate_,
        DELETED= deleted_,
        FILENAME= filename_,
        FILEPATH= filepath_,
        FILESIZE= filesize_
    WHERE ID= id_;
    i:= id_;
  ELSE -- insert
    i:=SEQ_SUCO.nextval;
    INSERT INTO BIENBANVANHANH(ID,SOBIENBAN,USERCREATE,TIMECREATE,DELETED,FILENAME,FILEPATH,FILESIZE) VALUES (i,sobienban_, usercreate_, timecreate_, 0,filename_, filepath_, filesize_);
  END IF;
  RETURN i;
END SAVE_BIENBANVANHANH;

/

