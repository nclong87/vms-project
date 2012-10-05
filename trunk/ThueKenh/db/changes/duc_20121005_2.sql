create or replace
function get_tiendo (
tuyenkenh_dexuat_id in number
)
return integer is PRAGMA AUTONOMOUS_TRANSACTION;
t1 NUMBER ;
t2 number;
iCount number;
iFinish number;
iDexuat number;
begin
  select count(*) into t1  from tuyenkenh_tieuchuan tt,tieuchuan tc where tt.tieuchuan_id=tc.id and tc.loaitieuchuan=1 and tuyenkenhdexuat_id=tuyenkenh_dexuat_id and tt.deleted=0 and tc.deleted=0;
  select count(*) into t2  from tieuchuan where loaitieuchuan=1 and deleted=0;
  t1:=t1/t2;
  if t1=1 then
    update tuyenkenhdexuat set trangthai=1 where id=tuyenkenh_dexuat_id;
    COMMIT;
    select dexuat_id into iDexuat from tuyenkenhdexuat where id=tuyenkenh_dexuat_id and deleted=0;
    select count(*) into iCount from tuyenkenhdexuat where  dexuat_id=iDexuat and  deleted=0;
    select count(*) into iFinish  from tuyenkenhdexuat where dexuat_id=iDexuat and trangthai=1 and  deleted=0;
    if iCount = iFinish then
      update dexuat set trangthai=1 where id=iDexuat;
      COMMIT;
    end if;
  end if;
  return t1*100;
end get_tiendo;