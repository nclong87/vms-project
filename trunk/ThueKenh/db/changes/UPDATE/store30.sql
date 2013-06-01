--------------------------------------------------------
--  DDL for Function SAVE_ACCOUNT
--------------------------------------------------------

  CREATE OR REPLACE FUNCTION "THUEKENH"."SAVE_ACCOUNT" 
(
  id_  in VARCHAR2,
  username_ in VARCHAR2,
  password_ in VARCHAR2,
  active_ in NUMBER,
  idkhuvuc_ in NUMBER,
  idphongban_ in NUMBER,
  idgroup_ in varchar2,
  mainmenu_ in varchar2,
  p_email in varchar2,
  p_phone in varchar2
)
RETURN NUMBER AS
n NUMBER;
BEGIN
  if(id_ is not null) then --update
    if(password_ is not null) then
      update ACCOUNTS set username =username_,IDGROUP = idgroup_, PASSWORD = password_, ACTIVE = active_, IDKHUVUC = idkhuvuc_, IDPHONGBAN = idphongban_, MAINMENU = mainmenu_, EMAIL = p_email, PHONE = p_phone
      where ID = to_number(id_);
    else
      update ACCOUNTS set username =username_, IDGROUP = idgroup_, ACTIVE = active_, IDKHUVUC = idkhuvuc_, IDPHONGBAN = idphongban_,MAINMENU = mainmenu_, EMAIL = p_email, PHONE = p_phone where ID = to_number(id_);
    end if;
  else --insert
    n := SEQ_ACCOUNTS.nextval;
    if(mainmenu_ <> '-1') then
      insert into ACCOUNTS(ID,USERNAME,PASSWORD,IDGROUP,ACTIVE,IDKHUVUC,IDPHONGBAN,MAINMENU,EMAIL,PHONE) values (n,username_,password_, idgroup_, active_,idkhuvuc_,idphongban_,mainmenu_,p_email,p_phone);
    else
      insert into ACCOUNTS(ID,USERNAME,PASSWORD,IDGROUP,ACTIVE,IDKHUVUC,IDPHONGBAN,MAINMENU,EMAIL,PHONE) values (n,username_,password_, idgroup_, active_,idkhuvuc_,idphongban_,null,p_email,p_phone);
    end if;
    return n;
  end if;
  RETURN id_;
END SAVE_ACCOUNT;

/

ALTER TABLE SUCOKENH 
ADD (CUOCTHANG NUMBER DEFAULT 0 );


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
  update SUCOKENH set THOIGIANMLL = THOIGIANMLL_,GIAMTRUMLL=GIAMTRUMLL_,CUOCTHANG =CUOCTHANG_ where ID = ID_;
  commit;
END PROC_JOB_UPDATE;

/

--------------------------------------------------------
--  DDL for Function SAVE_SUCOKENH
--------------------------------------------------------

  CREATE OR REPLACE FUNCTION "THUEKENH"."SAVE_SUCOKENH" 
(
  id_ in varchar2,
  tuyenkenh_id_ in varchar2,
  loaisuco_ in varchar2,
  phuluc_id_ in varchar2,
  thanhtoan_id_ in varchar2,
  thoidiembatdau_ in varchar2,
  thoidiemketthuc_ in varchar2,
  thoigianmll_ in varchar2,
  nguyennhan_ in varchar2,
  phuonganxuly_ in varchar2,
  nguoixacnhan_ in varchar2,
  giamtrumll_ in varchar2,
  trangthai_ in varchar2,
  usercreate_ in varchar2,
  timecreate_ in varchar2,
  deleted_ in varchar2,
  filename_ in varchar2,
  filepath_ in varchar2,
  filesize_ in varchar2,
  bienbanvanhanh_id_ in varchar2,
  cuocthang_ in varchar2
)
RETURN NUMBER AS i INTEGER :=0; 
BEGIN
  IF(id_ IS NOT NULL AND id_ >0) THEN --update
    UPDATE SUCOKENH 
    SET TUYENKENH_ID= tuyenkenh_id_, 
        LOAISUCO=loaisuco_,
        PHULUC_ID= phuluc_id_, 
        THANHTOAN_ID= thanhtoan_id_, 
        THOIDIEMBATDAU= thoidiembatdau_, 
        THOIDIEMKETTHUC= thoidiemketthuc_,
        THOIGIANMLL= thoigianmll_,
        NGUYENNHAN= nguyennhan_,
        PHUONGANXULY= phuonganxuly_,
        NGUOIXACNHAN= nguoixacnhan_,
        GIAMTRUMLL= giamtrumll_,
        TRANGTHAI= trangthai_,
        DELETED= deleted_,
        FILENAME= filename_,
        FILEPATH= filepath_,
        FILESIZE= filesize_,
        BIENBANVANHANH_ID=bienbanvanhanh_id_,
        cuocthang=cuocthang_
    WHERE ID= id_;
    i:= id_;
  ELSE -- insert
    i:=SEQ_SUCO.nextval;
    INSERT INTO SUCOKENH(ID,TUYENKENH_ID,LOAISUCO,PHULUC_ID,THANHTOAN_ID,THOIDIEMBATDAU,THOIDIEMKETTHUC,THOIGIANMLL,NGUYENNHAN,PHUONGANXULY,NGUOIXACNHAN,GIAMTRUMLL,TRANGTHAI,USERCREATE,TIMECREATE,DELETED,FILENAME,FILEPATH,FILESIZE,BIENBANVANHANH_ID,cuocthang) 
    VALUES (i, tuyenkenh_id_,loaisuco_, phuluc_id_, thanhtoan_id_, thoidiembatdau_, thoidiemketthuc_, thoigianmll_, nguyennhan_, phuonganxuly_, nguoixacnhan_, giamtrumll_, trangthai_, usercreate_, timecreate_, 0,filename_, filepath_, filesize_,bienbanvanhanh_id_,cuocthang_);
  END IF;
  RETURN i;
END SAVE_SUCOKENH;

/

ALTER TABLE SUCO_IMPORT 
ADD (CUOCTHANG NUMBER DEFAULT 0 );

--------------------------------------------------------
--  DDL for Procedure SAVE_SUCO_IMPORT
--------------------------------------------------------
set define off;

  CREATE OR REPLACE PROCEDURE "THUEKENH"."SAVE_SUCO_IMPORT" (
stt_ in NUMBER,
madiemdau_ in VARCHAR2,
madiemcuoi_ in VARCHAR2,
dungluong_ in VARCHAR2,
magiaotiep_ in VARCHAR2,
thoidiembatdau_ in NUMBER,
thoidiemketthuc_ in NUMBER,
nguyennhan_ in VARCHAR2,
phuonganxuly_ in VARCHAR2,
nguoixacnhan_ in VARCHAR2,
tuyenkenh_id_ in VARCHAR2,
phuluc_id_ in VARCHAR2,
thoigianmll_ in VARCHAR2,
giamtrumll_ in VARCHAR2,
loaisuco_ in NUMBER,
cuocthang_ in varchar2
) AS
i INTEGER := 0;
BEGIN
    i:=SEQ_SUCOIMPORT.nextval;
    --test(to_char(thoidiembatdau_,'DD-MON-YYYY HH24:MI'));
    insert into SUCO_IMPORT(STT,MADIEMDAU,MADIEMCUOI,DUNGLUONG,MAGIAOTIEP,THOIDIEMBATDAU,THOIDIEMKETTHUC,NGUYENNHAN,PHUONGANXULY,NGUOIXACNHAN,ID,TUYENKENH_ID,PHULUC_ID,THOIGIANMLL,GIAMTRUMLL,LOAISUCO,CUOCTHANG) 
    values (stt_,madiemdau_,madiemcuoi_,dungluong_,magiaotiep_,thoidiembatdau_,thoidiemketthuc_,nguyennhan_,phuonganxuly_,nguoixacnhan_,i,tuyenkenh_id_,phuluc_id_,thoigianmll_,giamtrumll_,loaisuco_,cuocthang_);
END SAVE_SUCO_IMPORT;

/

--------------------------------------------------------
--  DDL for Procedure PROC_IMPORT_SUCO
--------------------------------------------------------
set define off;

  CREATE OR REPLACE PROCEDURE "THUEKENH"."PROC_IMPORT_SUCO" (
pi_array in TABLE_NUMBER,
usercreate_ in varchar2,
timecreate_ in date
) AS 
i INTEGER := 1;
BEGIN
	for rec in (SELECT *  FROM SUCO_IMPORT  where ID in (select * from table(pi_array))) loop
      i := SEQ_SUCO.nextval;
			insert into SUCOKENH(ID,TUYENKENH_ID,PHULUC_ID,THANHTOAN_ID,THOIDIEMBATDAU,THOIDIEMKETTHUC,THOIGIANMLL,NGUYENNHAN,PHUONGANXULY,NGUOIXACNHAN,GIAMTRUMLL,TRANGTHAI,USERCREATE,TIMECREATE,DELETED,BIENBANVANHANH_ID,LOAISUCO,CUOCTHANG) 
      values (i,rec.TUYENKENH_ID,rec.PHULUC_ID,null,rec.THOIDIEMBATDAU,rec.THOIDIEMKETTHUC,rec.THOIGIANMLL,rec.NGUYENNHAN,rec.PHUONGANXULY,rec.NGUOIXACNHAN,rec.GIAMTRUMLL,0,usercreate_,timecreate_,0,0,rec.LOAISUCO,rec.CUOCTHANG);
    delete from SUCO_IMPORT where ID = rec.ID;
	end loop;
END PROC_IMPORT_SUCO;

/

--------------------------------------------------------
--  DDL for Function BC_GIAMTRUMLL
--------------------------------------------------------

  CREATE OR REPLACE FUNCTION "THUEKENH"."BC_GIAMTRUMLL" (
pDoiTacId in varchar2,
pFrom in number,
pEnd in number
) RETURN SYS_REFCURSOR AS
l_cursor SYS_REFCURSOR;
BEGIN
  OPEN l_cursor FOR select t3.*,t.*,loaigiaotiep,t5.tenphuluc,t6.sohopdong
    from sucokenh t 
      left join tuyenkenh t3 on t.tuyenkenh_id = t3.id
	  left join loaigiaotiep t2 on t3.giaotiep_id=t2.id
	  left join phuluc t5 on t5.id = t.PHULUC_ID
	  left join hopdong t6 on t6.id = t5.hopdong_id
      where t.deleted = 0 and t.phuluc_id is not null and t.thoidiembatdau >= pFrom and t.thoidiembatdau < pEnd and t3.doitac_id = pDoiTacId;
  RETURN l_cursor;
END BC_GIAMTRUMLL;

/

