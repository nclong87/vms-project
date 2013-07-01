CREATE TABLE TMP 
(
  COLUMN1 VARCHAR2(200) 
, COLUMN2 VARCHAR2(200) 
, COLUMN3 VARCHAR2(200) 
, COLUMN4 VARCHAR2(200) 
);

--------------------------------------------------------
--  DDL for Procedure PROC_JOB_UPDATE
--------------------------------------------------------
set define off;

  CREATE OR REPLACE PROCEDURE "THUEKENH"."PROC_JOB_UPDATE" (
ID_ in varchar2,
THOIGIANMLL_ in varchar2,
GIAMTRUMLL_ in varchar2,
CUOCTHANG_ in varchar2
) AS
BEGIN
  --update SUCOKENH set THOIGIANMLL = THOIGIANMLL_,GIAMTRUMLL=GIAMTRUMLL_,CUOCTHANG =CUOCTHANG_ where ID = ID_;
  insert into tmp values(ID_, THOIGIANMLL_,GIAMTRUMLL_,CUOCTHANG_);
  commit;
END PROC_JOB_UPDATE;

/


--------------------------------------------------------
--  DDL for Procedure PROC_JOB_UPDATE2
--------------------------------------------------------
set define off;

  CREATE OR REPLACE PROCEDURE "THUEKENH"."PROC_JOB_UPDATE2" AS 
BEGIN
  for rec in (select * from tmp) loop
    update SUCOKENH t0 set THOIGIANMLL = rec.column2,GIAMTRUMLL=rec.column3,CUOCTHANG =rec.column4 where ID = rec.column1;
  end loop;
  
  NULL;
END PROC_JOB_UPDATE2;

/

