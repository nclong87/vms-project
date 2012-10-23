create or replace function capnhattiendo
(
tuyenkenh_tieuchuan_id_ in varchar2,
tieuchuan_id_ in varchar2,
username_ in varchar2
)
return number as 
begin

INSERT INTO TUYENKENH_TIEUCHUAN (TUYENKENHDEXUAT_ID, TIEUCHUAN_ID, USERCREATE, TIMECREATE, DELETED) 
VALUES (tuyenkenh_tieuchuan_id_, tieuchuan_id_, username_, sysdate, '0');
  return null;
end capnhattiendo;