create table "THUEKENH".LICHSU_PHULUC as select * from "THUEKENH"."LICHSU_TUYENKENH" where '1' = '';ALTER TABLE LICHSU_PHULUC RENAME COLUMN TUYENKENH_ID TO PHULUC_ID;ALTER TABLE LICHSU_PHULUC  MODIFY (PHULUC_ID NUMBER );