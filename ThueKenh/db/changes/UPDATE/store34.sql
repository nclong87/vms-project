--------------------------------------------------------
--  DDL for Function BC_ISO_TRUYENDANKENHTHUE
--------------------------------------------------------

  CREATE OR REPLACE FUNCTION "THUEKENH"."BC_ISO_TRUYENDANKENHTHUE" (
pFrom in date,
pEnd in date
) RETURN SYS_REFCURSOR AS
l_cursor SYS_REFCURSOR;
BEGIN
  OPEN l_cursor FOR select * from (select rownum as rn,t0.id,(diemdau.matram ||' - '|| diemdau.diachi) DIEMDAU,(diemcuoi.matram ||' - '|| diemcuoi.diachi) DIEMCUOI,t0.soluong,t0.dungluong,t2.loaigiaotiep,t0.loaikenh,t3.tendoitac,t6.sohopdong,t5.tenphuluc,t0.ngaybatdau,t4.thanhtien,FIND_SUCOBYTUYENKENH(t0.id,pFrom,pEnd,t5.NGAYHIEULUC,t5.NGAYHETHIEULUC) as SUCOKENH from tuyenkenh t0
left join tram diemdau on t0.madiemdau = diemdau.matram
left join tram diemcuoi on t0.madiemcuoi = diemcuoi.matram
left join loaigiaotiep t2 on t0.giaotiep_id=t2.id
left join doitac t3 on t3.id = t0.doitac_id
left join chitietphuluc_tuyenkenh t4 on t4.tuyenkenh_id = t0.id
left join phuluc t5 on t5.chitietphuluc_id = t4.CHITIETPHULUC_ID
left join hopdong t6 on t6.id = t5.hopdong_id
where t0.deleted =0 and t5.deleted = 0 and ( (t5.ngayhethieuluc is null and t5.ngayhieuluc  < pEnd + 1) or (t5.ngayhethieuluc is not null and t5.ngayhethieuluc >= pFrom and t5.ngayhieuluc < pEnd + 1 ) )
order by t0.id
) dulieu;
  RETURN l_cursor;
END BC_ISO_TRUYENDANKENHTHUE;

/

