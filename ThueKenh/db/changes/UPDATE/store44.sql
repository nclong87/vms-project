--------------------------------------------------------
--  DDL for Function FN_SAVEDOISOATCUOC
--------------------------------------------------------

  CREATE OR REPLACE FUNCTION "THUEKENH"."FN_SAVEDOISOATCUOC" (
p_doisoatcuoc_id in number,
doitac_id_ in varchar2,
tungay_ in date,
denngay_ in date,
phulucs in TABLE_VARCHAR,
sucos in TABLE_VARCHAR,
timecreate_ in number,
matlienlactu_ in date,
matlienlacden_ in date
)  RETURN SYS_REFCURSOR AS
l_cursor SYS_REFCURSOR;
-- Bien dung cho bang DOISOATCUOC
vDoiSoatCuocId number;
vDSCThanhTien number := 0;
vDSCDaThanhToan number := 0;
vDSCDauNoiHoaMang number := 0;
vDSCConThanhToan number := 0;
vGiamTruMLL number := 0;
-- Bien dung cho bang DOISOATCUOC_PHULUC
vThang number;
vNgay number;
vSoNgay number;
vTuNgay date;
vDenNgay date;
vThanhTien number;
vDauNoiHoaMang number;
vDaThanhToan number;
vConThanhToan number;
vStr varchar2(100);
vStt number := 0;
BEGIN
    if(p_doisoatcuoc_id is not null) then --update
        vDoiSoatCuocId := p_doisoatcuoc_id;
        update DOISOATCUOC set DOITAC_ID = doitac_id_, TUNGAY = tungay_, DENNGAY = denngay_, MATLIENLACTU = matlienlactu_, MATLIENLACDEN = matlienlacden_ where ID = vDoiSoatCuocId;
        delete from DOISOATCUOC_PHULUC where DOISOATCUOC_ID = vDoiSoatCuocId;
        delete from DOISOATCUOC_SUCO where DOISOATCUOC_ID = vDoiSoatCuocId;
    else
        vDoiSoatCuocId := SEQ_DOISOATCUOC.nextval;
        insert into DOISOATCUOC(ID,DOITAC_ID,TUNGAY,DENNGAY,TIMECREATE,DELETED,MATLIENLACTU,MATLIENLACDEN) values (vDoiSoatCuocId,doitac_id_,tungay_,denngay_,timecreate_,timecreate_,matlienlactu_,matlienlacden_);
    end if;
    dbms_output.put_line('sadad');
    for rec in (select t.*,case when PHULUCTHAYTHE_ID is not null then PHULUCTHAYTHE_ID else ID end as num from PHULUC t where DELETED = 0 and ID in ((select * from table(phulucs))) order by num desc) loop
    vStt := vStt + 1;
    dbms_output.put_line('sadad');
        if(rec.THANG is null) then -- phu luc ke khai thanh toan lan dau
            vTuNgay := rec.NGAYHIEULUC;
            vDauNoiHoaMang := rec.CUOCDAUNOI;
        else
            vTuNgay := tungay_;
            vDauNoiHoaMang := 0;
        end if;

        if(rec.NGAYHETHIEULUC < denngay_) then
            vDenNgay := rec.NGAYHETHIEULUC;
        else
            vDenNgay := denngay_;
        end if;
        vstr := time_between(vTuNgay,vDenNgay);
        vNgay := to_number(substr(vstr,instr(vstr,',') + 1));
        vThang := to_number(substr(vstr,1,instr(vstr,',')-1));
        vSoNgay := vThang * 30 + vNgay;
        vDaThanhToan := 0;
        if(vSoNgay < 0) then -- lay lai so tien da thanh toan cho phu luc nay o thang truoc (do ky tre)
            for recDSC_PL in (select t2.* from thanhtoan t left join doisoatcuoc t1 on t.doisoatcuoc_id = t1.id left join doisoatcuoc_phuluc t2 on t2.doisoatcuoc_id = t1.id where t2.phuluc_id = rec.ID and t.DELETED = 0 and t1.DELETED=0 and t1.denngay >= vDenNgay order by t.TIMECREATE desc) loop
                -- vSoNgay := vSoNgay + (recDSC_PL.SOTHANG * 30) + recDSC_PL.SONGAY;
                vDaThanhToan := vDaThanhToan + recDSC_PL.CONTHANHTOAN - recDSC_PL.DAUNOIHOAMANG;
                vTuNgay := recDSC_PL.TUNGAY;
            end loop;
        end if;
        vstr := time_between(vTuNgay,vDenNgay);
        vNgay := to_number(substr(vstr,instr(vstr,',') + 1));
        vThang := to_number(substr(vstr,1,instr(vstr,',')-1));
        vSoNgay := vThang * 30 + vNgay;
    if(vSoNgay < 0) then -- chon sai phu luc
      insert into DOISOATCUOC_PHULUC(DOISOATCUOC_ID,PHULUC_ID,TUNGAY,DENNGAY,SOTHANG,SONGAY,THANHTIEN,DAUNOIHOAMANG,DATHANHTOAN,CONTHANHTOAN,STT) values (vDoiSoatCuocId,rec.ID,null,null,0,0,0,0,0,0,vStt);
    else
      vThanhTien := floor(rec.GIATRITRUOCTHUE * (vSoNgay / 30));
      
      vConThanhToan := vThanhTien + vDauNoiHoaMang - vDaThanhToan;
      insert into DOISOATCUOC_PHULUC(DOISOATCUOC_ID,PHULUC_ID,TUNGAY,DENNGAY,SOTHANG,SONGAY,THANHTIEN,DAUNOIHOAMANG,DATHANHTOAN,CONTHANHTOAN,STT) values (vDoiSoatCuocId,rec.ID,vTuNgay,vDenNgay,vThang,vNgay,vThanhTien,vDauNoiHoaMang,vDaThanhToan,vConThanhToan,vStt);

      vDSCThanhTien:= vDSCThanhTien + vThanhTien;
      vDSCDauNoiHoaMang:= vDSCDauNoiHoaMang + vDauNoiHoaMang;
      vDSCDaThanhToan:= vDSCDaThanhToan + vDaThanhToan;
      vDSCConThanhToan:= vDSCConThanhToan + vConThanhToan;
    end if;
    end loop;

    --Tinh gia tri giam tru mat lien lac
    for rec in (select * from SUCOKENH where DELETED = 0 and ID in ((select * from table(sucos)))) loop
    insert into DOISOATCUOC_SUCO(DOISOATCUOC_ID,SUCO_ID) values (vDoiSoatCuocId,rec.ID);
        vGiamTruMLL := vGiamTruMLL + rec.GIAMTRUMLL;
    end loop;
    vDSCConThanhToan := vDSCConThanhToan - vGiamTruMLL;
    -- Cap nhat lai bang doi soat cuoc
    update DOISOATCUOC SET GIAMTRUMLL = vGiamTruMLL, THANHTIEN = vDSCThanhTien, TONGDAUNOIHOAMANG = vDSCDauNoiHoaMang, TONGDATHANHTOAN = vDSCDaThanhToan, TONGCONTHANHTOAN = vDSCConThanhToan where ID = vDoiSoatCuocId;
  open l_cursor for select vDoiSoatCuocId as ID,vDSCThanhTien as THANHTIEN,vGiamTruMLL as GIAMTRUMLL, vDSCDauNoiHoaMang as TONGDAUNOIHOAMANG, vDSCDaThanhToan as TONGDATHANHTOAN, vDSCConThanhToan as TONGCONTHANHTOAN from dual;
  return l_cursor;
END FN_SAVEDOISOATCUOC;

/

