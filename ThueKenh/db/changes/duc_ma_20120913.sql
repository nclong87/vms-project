ALTER TABLE CONGTHUC 
ADD (MA VARCHAR2(20) );

CREATE UNIQUE INDEX CONGTHUC_INDEX1 ON CONGTHUC (MA);

ALTER TABLE DOITAC 
ADD (MA VARCHAR2(20) );

CREATE UNIQUE INDEX DOITAC_INDEX1 ON DOITAC (MA);

ALTER TABLE DUAN 
ADD (MA VARCHAR2(20) );

CREATE UNIQUE INDEX DUAN_INDEX1 ON DUAN (MA);

ALTER TABLE KHUVUC 
ADD (MA VARCHAR2(20) );

CREATE UNIQUE INDEX KHUVUC_INDEX1 ON KHUVUC (MA);

ALTER TABLE LOAIGIAOTIEP 
ADD (MA VARCHAR2(20) );

CREATE UNIQUE INDEX LOAIGIAOTIEP_INDEX1 ON LOAIGIAOTIEP (MA);

ALTER TABLE PHONGBAN 
ADD (MA VARCHAR2(20) );

CREATE UNIQUE INDEX PHONGBAN_INDEX1 ON PHONGBAN (MA);