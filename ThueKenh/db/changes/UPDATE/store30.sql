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
