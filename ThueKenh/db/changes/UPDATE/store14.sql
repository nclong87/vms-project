--------------------------------------------------------
--  DDL for Function SAVE_TUYENKENHDEXUAT
--------------------------------------------------------

  CREATE OR REPLACE FUNCTION "THUEKENH"."SAVE_TUYENKENHDEXUAT" (
id_ in VARCHAR2,
tuyenkenh_id_ in VARCHAR2,
madiemdau_ in VARCHAR2,
madiemcuoi_ in VARCHAR2,
giaotiep_id_ in VARCHAR2,
duan_id_ in VARCHAR2,
phongban_id_ in VARCHAR2,
doitac_id_ in VARCHAR2,
dungluong_ in VARCHAR2,
ngaydenghibangiao_ in VARCHAR2,
ngayhenbangiao_ in VARCHAR2,
thongtinlienhe_ in VARCHAR2,
soluong_ in NUMBER,
soluong_old in NUMBER,
usercreate_ in VARCHAR2,
timecreate_ in VARCHAR2
) RETURN NUMBER AS
i INTEGER := 0;
madoitac varchar2(50);
matuyenkenh varchar2(20);
id_tuyenkenh varchar2(50);
str varchar2(500) := '';
BEGIN
	if(tuyenkenh_id_ is not null) then --update
		update TUYENKENH set DUAN_ID = duan_id_,PHONGBAN_ID = phongban_id_,DOITAC_ID = doitac_id_,DUNGLUONG = dungluong_,SOLUONG = SOLUONG + (soluong_ - soluong_old),TRANGTHAI_BAK = TRANGTHAI, TRANGTHAI = 2  where ID = tuyenkenh_id_ and DELETED = 0;
		id_tuyenkenh := tuyenkenh_id_;
    PROC_INSERT_LICHSU_TUYENKENH(usercreate_,id_tuyenkenh,3,'');
	else --insert
		i:=GET_SOTUYENKENH(doitac_id_) + 1;
    select ma into madoitac from doitac where id = doitac_id_;
    id_tuyenkenh := FN_GEN_MATUYENKENH(doitac_id_,madoitac);
		insert into TUYENKENH(ID, MADIEMDAU, MADIEMCUOI, GIAOTIEP_ID, DUAN_ID, PHONGBAN_ID, DOITAC_ID, DUNGLUONG, SOLUONG, TRANGTHAI, USERCREATE, TIMECREATE, DELETED) values (id_tuyenkenh, madiemdau_, madiemcuoi_, giaotiep_id_, duan_id_, phongban_id_, doitac_id_, dungluong_, soluong_, 1, usercreate_, timecreate_, 0);
		PROC_INSERT_LICHSU_TUYENKENH(usercreate_,id_tuyenkenh,1,'');
	end if;
	if(id_ is not null and id_>0) then --update
		update TUYENKENHDEXUAT set TUYENKENH_ID = id_tuyenkenh,NGAYDENGHIBANGIAO = ngaydenghibangiao_,NGAYHENBANGIAO = ngayhenbangiao_,THONGTINLIENHE = thongtinlienhe_,SOLUONG = soluong_ where ID = id_;
		i := id_;
		str := '<root><element><id>'||i||'</id></element></root>';
		PROC_INSERT_LICHSU_TUYENKENH(usercreate_,id_tuyenkenh,8,str);
	else --insert
		i:=SEQ_TUYENKENHDEXUAT.nextval;
		insert into TUYENKENHDEXUAT(ID, DEXUAT_ID, TUYENKENH_ID, BANGIAO_ID, NGAYDENGHIBANGIAO, NGAYHENBANGIAO, THONGTINLIENHE, TRANGTHAI, SOLUONG) values (i, NULL, id_tuyenkenh, NULL, ngaydenghibangiao_, ngayhenbangiao_, thongtinlienhe_, 0, soluong_);
		str := '<root><element><id>'||i||'</id></element></root>';
		PROC_INSERT_LICHSU_TUYENKENH(usercreate_,id_tuyenkenh,6,str);
	end if;
	return i;
END SAVE_TUYENKENHDEXUAT;

/

