----------------------------------------------------------  DDL for Procedure SEND_EMAIL--------------------------------------------------------set define off;  CREATE OR REPLACE PROCEDURE "THUEKENH"."SEND_EMAIL" (p_tuyenkenh_id IN VARCHAR2, p_type IN NUMBER,p_content IN CLOB)  ASv_email_content CLOB;v_phongban_id number;BEGIN  select phongban_id into v_phongban_id from TUYENKENH where ID = p_tuyenkenh_id;  if(p_content is null or p_content = '') then    if(p_type = 1) then -- bat dau ban giao      v_email_content := 'Tuyen kenh '||p_tuyenkenh_id|| ' : bat dau ban giao';    elsif (p_type = 2) then -- toi deadline chua ban giao      v_email_content := 'Tuyen kenh '||p_tuyenkenh_id|| ' : da den deadline nhung chua ban giao';    elsif (p_type = 3) then -- da ban giao xong      v_email_content := 'Tuyen kenh '||p_tuyenkenh_id|| ' : da ban giao xong';    end if;  else    v_email_content := p_content;  end if;END SEND_EMAIL;/----------------------------------------------------------  DDL for Procedure SEND_SMS--------------------------------------------------------set define off;  CREATE OR REPLACE PROCEDURE "THUEKENH"."SEND_SMS" (p_tuyenkenh_id IN VARCHAR2, p_type IN NUMBER,p_content in varchar2) ASv_sms_content varchar2(1000);v_phongban_id number;BEGIN  select phongban_id into v_phongban_id from TUYENKENH where ID = p_tuyenkenh_id;  if(p_content is null or p_content = '') then    if(p_type = 1) then -- bat dau ban giao      v_sms_content := 'Tuyen kenh '||p_tuyenkenh_id|| ' : bat dau ban giao';    elsif (p_type = 2) then -- toi deadline chua ban giao      v_sms_content := 'Tuyen kenh '||p_tuyenkenh_id|| ' : da den deadline nhung chua ban giao';    elsif (p_type = 3) then -- da ban giao xong      v_sms_content := 'Tuyen kenh '||p_tuyenkenh_id|| ' : da ban giao xong';    end if;  else    v_sms_content := p_content;  end if;  for rec in (select * from ACCOUNTS where IDPHONGBAN = v_phongban_id) loop    if(rec.phone is not null) then      insert into sms values (sysdate,rec.phone,v_sms_content);    end if;  end loop;END SEND_SMS;/----------------------------------------------------------  DDL for Procedure PROC_SCHEDULE--------------------------------------------------------set define off;  CREATE OR REPLACE PROCEDURE "THUEKENH"."PROC_SCHEDULE" AS BEGIN  for rec in (select t.ID,t.TUYENKENH_ID from TUYENKENHDEXUAT t left join TUYENKENH t1 on t.TUYENKENH_ID=t1.ID where t.NGAYHENBANGIAO < sysdate and t.TRANGTHAI = 0 and t.FLAG_SENDMAIL is null) loop    SEND_SMS(rec.TUYENKENH_ID,2,null);    SEND_EMAIL(rec.TUYENKENH_ID,2,null);    update TUYENKENHDEXUAT set FLAG_SENDMAIL = 1 where ID = rec.ID;  end loop;END PROC_SCHEDULE;/ALTER TABLE TUYENKENHDEXUAT ADD (FLAG_SENDMAIL NUMBER );ALTER TABLE ACCOUNTS ADD (EMAIL VARCHAR2(200) );ALTER TABLE ACCOUNTS ADD (PHONE VARCHAR2(50) );----------------------------------------------------------  DDL for Function SAVE_ACCOUNT--------------------------------------------------------  CREATE OR REPLACE FUNCTION "THUEKENH"."SAVE_ACCOUNT" (	id_	in VARCHAR2,	username_ in VARCHAR2,	password_ in VARCHAR2,	active_ in NUMBER,	idkhuvuc_ in NUMBER,	idphongban_ in NUMBER,  idgroup_ in varchar2,  mainmenu_ in varchar2,  p_email in varchar2,  p_phone in varchar2)RETURN NUMBER ASn NUMBER;BEGIN	if(id_ is not null) then --update    if(password_ is not null) then      update ACCOUNTS set IDGROUP = idgroup_, PASSWORD = password_, ACTIVE = active_, IDKHUVUC = idkhuvuc_, IDPHONGBAN = idphongban_, MAINMENU = mainmenu_, EMAIL = p_email, PHONE = p_phone      where ID = to_number(id_);    else      update ACCOUNTS set IDGROUP = idgroup_, ACTIVE = active_, IDKHUVUC = idkhuvuc_, IDPHONGBAN = idphongban_,MAINMENU = mainmenu_, EMAIL = p_email, PHONE = p_phone where ID = to_number(id_);    end if;	else --insert		n := SEQ_ACCOUNTS.nextval;    if(mainmenu_ <> '-1') then      insert into ACCOUNTS(ID,USERNAME,PASSWORD,IDGROUP,ACTIVE,IDKHUVUC,IDPHONGBAN,MAINMENU,EMAIL,PHONE) values (n,username_,password_, idgroup_, active_,idkhuvuc_,idphongban_,mainmenu_,p_email,p_phone);    else      insert into ACCOUNTS(ID,USERNAME,PASSWORD,IDGROUP,ACTIVE,IDKHUVUC,IDPHONGBAN,MAINMENU,EMAIL,PHONE) values (n,username_,password_, idgroup_, active_,idkhuvuc_,idphongban_,null,p_email,p_phone);    end if;    return n;  end if;  RETURN id_;END SAVE_ACCOUNT;/----------------------------------------------------------  DDL for Function FN_FIND_ACCOUNTS--------------------------------------------------------  CREATE OR REPLACE FUNCTION "THUEKENH"."FN_FIND_ACCOUNTS" (iDisplayStart IN NUMBER,   iDisplayLength IN NUMBER, username_ in varchar2,phongban_ in varchar2,khuvuc_ in varchar2,active_ in varchar2) RETURN SYS_REFCURSOR ASl_cursor SYS_REFCURSOR;v_vcsql VARCHAR2(1000);v_vcsqlwhere VARCHAR2(500);i NUMBER;BEGIN	v_vcsqlwhere := ' 1 = 1 ';	if(username_ is not null) then		v_vcsqlwhere := v_vcsqlwhere ||' and USERNAME like '''||username_||'%'' ';	end if;	if(phongban_ is not null) then		v_vcsqlwhere := v_vcsqlwhere ||' and IDPHONGBAN = '||phongban_||' ';	end if;	if(khuvuc_ is not null) then		v_vcsqlwhere := v_vcsqlwhere ||' and IDKHUVUC = '||khuvuc_||' ';	end if;	if(active_ is not null) then		v_vcsqlwhere := v_vcsqlwhere ||' and t0.ACTIVE = '||active_||' ';	end if;	v_vcsql := 'select rownum as rn,dulieu.* from (SELECT t0.ID,USERNAME,PASSWORD,IDGROUP,t0.ACTIVE,IDKHUVUC,IDPHONGBAN,TENPHONGBAN,TENKHUVUC,NAMEMENU,EMAIL,PHONE FROM ACCOUNTS t0 left join PHONGBAN t1 on t0.IDPHONGBAN = t1.ID left join KHUVUC t2 on t0.IDKHUVUC = t2.ID left join MENU t3 on t0.MAINMENU = t3.ID  WHERE ' || v_vcsqlwhere || ' order by ID desc) dulieu ';	v_vcsql := 'SELECT * FROM (' || v_vcsql || ') WHERE rn > ' || iDisplayStart || ' and rn <= ' || (iDisplayStart+iDisplayLength);	--dbms_output.put_line(v_vcsql); --test(v_vcsql);	OPEN l_cursor FOR v_vcsql;	RETURN l_cursor;END FN_FIND_ACCOUNTS;/CREATE TABLE SMS (  DATE_SEND DATE , PHONE VARCHAR2(50) , CONTENT VARCHAR2(1000) );----------------------------------------------------------  DDL for Function TIME_BETWEEN--------------------------------------------------------  CREATE OR REPLACE FUNCTION "THUEKENH"."TIME_BETWEEN" (p_from in date,p_end in date) RETURN varchar2 ASl_cursor SYS_REFCURSOR;v_year number;v_month number;v_day number;v_d1 date;v_d2 date;BEGIN	v_d1 := trunc(trunc(p_from, 'MM'), 'MM');	v_d2 := LAST_DAY(p_end);	if(p_from = v_d1 and p_end = v_d2) then		v_month := floor(MONTHS_BETWEEN (v_d2, v_d1)) + 1;		v_day := 0;	elsif (p_from = v_d1) then		v_d2 := trunc(trunc(p_end, 'MM'), 'MM');		v_month := floor(MONTHS_BETWEEN (v_d2, v_d1));		v_day := p_end - v_d2 + 1;	elsif (p_end = v_d2) then		v_d1 := LAST_DAY(p_from) + 1;		v_month := floor(MONTHS_BETWEEN (v_d2, v_d1)) + 1;		v_day := v_d1 - p_from;	else		v_d1 := LAST_DAY(p_from) + 1;		v_d2 := trunc(trunc(p_end, 'MM'), 'MM');    if(v_d1 > p_end) then      v_month := 0;      v_day := p_end - p_from + 1;    else      v_month := floor(MONTHS_BETWEEN (v_d2, v_d1));      v_day := (v_d1 - p_from) + (p_end - v_d2);    end if;	end if;	RETURN v_month||','||v_day;END TIME_BETWEEN;/----------------------------------------------------------  DDL for Function FN_SAVEDOISOATCUOC--------------------------------------------------------  CREATE OR REPLACE FUNCTION "THUEKENH"."FN_SAVEDOISOATCUOC" (p_doisoatcuoc_id in number,doitac_id_ in varchar2,tungay_ in date,denngay_ in date,phulucs in TABLE_VARCHAR,sucos in TABLE_VARCHAR,timecreate_ in number,matlienlactu_ in date,matlienlacden_ in date)  RETURN SYS_REFCURSOR ASl_cursor SYS_REFCURSOR;-- Bien dung cho bang DOISOATCUOCvDoiSoatCuocId number;vDSCThanhTien number := 0;vDSCDaThanhToan number := 0;vDSCDauNoiHoaMang number := 0;vDSCConThanhToan number := 0;vGiamTruMLL number := 0;-- Bien dung cho bang DOISOATCUOC_PHULUC vThang number;vNgay number;vSoNgay number;vTuNgay date;vDenNgay date;vThanhTien number;vDauNoiHoaMang number;vDaThanhToan number;vConThanhToan number;vStr varchar2(100);BEGIN    if(p_doisoatcuoc_id is not null) then --update        vDoiSoatCuocId := p_doisoatcuoc_id;        update DOISOATCUOC set DOITAC_ID = doitac_id_, TUNGAY = tungay_, DENNGAY = denngay_, MATLIENLACTU = matlienlactu_, MATLIENLACDEN = matlienlacden_ where ID = vDoiSoatCuocId;        delete from DOISOATCUOC_PHULUC where DOISOATCUOC_ID = vDoiSoatCuocId;        delete from DOISOATCUOC_SUCO where DOISOATCUOC_ID = vDoiSoatCuocId;    else        vDoiSoatCuocId := SEQ_DOISOATCUOC.nextval;        insert into DOISOATCUOC(ID,DOITAC_ID,TUNGAY,DENNGAY,TIMECREATE,DELETED,MATLIENLACTU,MATLIENLACDEN) values (vDoiSoatCuocId,doitac_id_,tungay_,denngay_,timecreate_,timecreate_,matlienlactu_,matlienlacden_);    end if;        for rec in (select * from PHULUC where DELETED = 0 and ID in ((select * from table(phulucs)))) loop        if(rec.THANG is null) then -- phu luc ke khai thanh toan lan dau            vTuNgay := rec.NGAYHIEULUC;            vDauNoiHoaMang := rec.CUOCDAUNOI;        else            vTuNgay := tungay_;            vDauNoiHoaMang := 0;        end if;                if(rec.NGAYHETHIEULUC < denngay_) then            vDenNgay := rec.NGAYHETHIEULUC;        else            vDenNgay := denngay_;        end if;        vstr := time_between(vTuNgay,vDenNgay);        vNgay := to_number(substr(vstr,instr(vstr,',') + 1));        vThang := to_number(substr(vstr,1,instr(vstr,',')-1));        vSoNgay := vThang * 30 + vNgay;        vDaThanhToan := 0;        if(vSoNgay < 0) then -- lay lai so tien da thanh toan cho phu luc nay o thang truoc (do ky tre)            for recDSC_PL in (select t2.* from thanhtoan t left join doisoatcuoc t1 on t.doisoatcuoc_id = t1.id left join doisoatcuoc_phuluc t2 on t2.doisoatcuoc_id = t1.id where t2.phuluc_id = rec.ID and t1.tungay <= vDenNgay and t1.denngay >= vDenNgay order by t.TIMECREATE desc) loop                vSoNgay := vSoNgay + (recDSC_PL.SOTHANG * 30) + recDSC_PL.SONGAY;                vDaThanhToan := vDaThanhToan + recDSC_PL.CONTHANHTOAN;                vTuNgay := recDSC_PL.TUNGAY;            end loop;			vstr := time_between(vTuNgay,vDenNgay);			vNgay := to_number(substr(vstr,instr(vstr,',') + 1));			vThang := to_number(substr(vstr,1,instr(vstr,',')-1));        end if;		if(vSoNgay < 0) then -- chon sai phu luc			insert into DOISOATCUOC_PHULUC(DOISOATCUOC_ID,PHULUC_ID,TUNGAY,DENNGAY,SOTHANG,SONGAY,THANHTIEN,DAUNOIHOAMANG,DATHANHTOAN,CONTHANHTOAN) values (vDoiSoatCuocId,rec.ID,null,null,0,0,0,0,0,0);		else			vThanhTien := floor(rec.GIATRITRUOCTHUE / 30 * vSoNgay);			vConThanhToan := vThanhTien + vDauNoiHoaMang - vDaThanhToan;			insert into DOISOATCUOC_PHULUC(DOISOATCUOC_ID,PHULUC_ID,TUNGAY,DENNGAY,SOTHANG,SONGAY,THANHTIEN,DAUNOIHOAMANG,DATHANHTOAN,CONTHANHTOAN) values (vDoiSoatCuocId,rec.ID,vTuNgay,vDenNgay,vThang,vNgay,vThanhTien,vDauNoiHoaMang,vDaThanhToan,vConThanhToan);						vDSCThanhTien:= vDSCThanhTien + vThanhTien;			vDSCDauNoiHoaMang:= vDSCDauNoiHoaMang + vDauNoiHoaMang;			vDSCDaThanhToan:= vDSCDaThanhToan + vDaThanhToan;			vDSCConThanhToan:= vDSCConThanhToan + vConThanhToan;		end if;    end loop;        --Tinh gia tri giam tru mat lien lac    for rec in (select * from SUCOKENH where DELETED = 0 and ID in ((select * from table(sucos)))) loop    insert into DOISOATCUOC_SUCO(DOISOATCUOC_ID,SUCO_ID) values (vDoiSoatCuocId,rec.ID);        vGiamTruMLL := vGiamTruMLL + rec.GIAMTRUMLL;    end loop;    vDSCConThanhToan := vDSCConThanhToan - vGiamTruMLL;    -- Cap nhat lai bang doi soat cuoc    update DOISOATCUOC SET GIAMTRUMLL = vGiamTruMLL, THANHTIEN = vDSCThanhTien, TONGDAUNOIHOAMANG = vDSCDauNoiHoaMang, TONGDATHANHTOAN = vDSCDaThanhToan, TONGCONTHANHTOAN = vDSCConThanhToan where ID = vDoiSoatCuocId;  open l_cursor for select vDoiSoatCuocId as ID,vDSCThanhTien as THANHTIEN,vGiamTruMLL as GIAMTRUMLL, vDSCDauNoiHoaMang as TONGDAUNOIHOAMANG, vDSCDaThanhToan as TONGDATHANHTOAN, vDSCConThanhToan as TONGCONTHANHTOAN from dual;  return l_cursor;END FN_SAVEDOISOATCUOC;/----------------------------------------------------------  DDL for Procedure PROC_UPDATE_TIEN_DO--------------------------------------------------------set define off;  CREATE OR REPLACE PROCEDURE "THUEKENH"."PROC_UPDATE_TIEN_DO" (tuyenkenh_dexuat_id in number,arr_tieuchuan_id in TABLE_VARCHAR,username_ in varchar2,createtime_ in varchar2)ASiTemp number:=0;iCount number := 0;tong_tieu_chuan number := 0;chua_dat number := 0;iDexuat number;tiendo_ number;iTuyenKenhDeXuatChuaBanGiao number;i number;tuyenkenh_id_ varchar2(50) := null;str varchar2(500) := '';begin	select TUYENKENH_ID into tuyenkenh_id_  from TUYENKENHDEXUAT where DELETED=0 and ID = tuyenkenh_dexuat_id;	if(tuyenkenh_id_ is not null) then		--lay cac tieu chuan da dat dc		DELETE from TUYENKENH_TIEUCHUAN where TUYENKENHDEXUAT_ID = tuyenkenh_dexuat_id;		--neu cac tieu chuan ton` tai		if(arr_tieuchuan_id.count() > 0) then			for i in arr_tieuchuan_id.first .. arr_tieuchuan_id.last loop				--them tieu chuan da dat dc				INSERT INTO TUYENKENH_TIEUCHUAN (TUYENKENHDEXUAT_ID, TIEUCHUAN_ID, USERCREATE, TIMECREATE, DELETED) 				VALUES (tuyenkenh_dexuat_id, arr_tieuchuan_id(i), username_, createtime_, '0');				select count(*) into iTemp from tieuchuan where id=arr_tieuchuan_id(i) and loaitieuchuan=1;				iCount := iCount + iTemp;				iTemp:=0;			end loop;		end if;				select count(*) into tong_tieu_chuan  from tieuchuan where deleted=0 and loaitieuchuan=1;		select count(*) into chua_dat  from tieuchuan where deleted=0 and loaitieuchuan = 1 and id not in (select * from table(arr_tieuchuan_id));		if(chua_dat = 0) then			update tuyenkenhdexuat set TIENDO = 100,trangthai=1 where id=tuyenkenh_dexuat_id;      -- send mail/sms      SEND_SMS(tuyenkenh_id_,3,null);      SEND_EMAIL(tuyenkenh_id_,3,null);			select dexuat_id into iDexuat from tuyenkenhdexuat where id=tuyenkenh_dexuat_id and deleted=0;			if(iDexuat is not null) then				select count(*) into iTuyenKenhDeXuatChuaBanGiao  from tuyenkenhdexuat where dexuat_id=iDexuat and trangthai!=1 and  deleted=0;				if(iTuyenKenhDeXuatChuaBanGiao = 0) then					update dexuat set trangthai=1 where id=iDexuat;				end if;			end if;		else			if(tong_tieu_chuan = 0) then				tiendo_ := 0;				update tuyenkenhdexuat set TIENDO = tiendo_ where id=tuyenkenh_dexuat_id;			else				tiendo_ := round(iCount/tong_tieu_chuan*100,2);			update tuyenkenhdexuat set TIENDO = tiendo_,trangthai=0 where id=tuyenkenh_dexuat_id;			end if;		end if;				--update history tuyenkenh    str := '<root><element><id>'||tuyenkenh_dexuat_id||'</id></element></root>';		PROC_INSERT_LICHSU_TUYENKENH(username_,tuyenkenh_id_,9,str);	end if;end PROC_UPDATE_TIEN_DO;/