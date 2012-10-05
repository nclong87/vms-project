create or replace
function get_tiendo (
tuyenkenh_dexuat_id in number
)
return integer is PRAGMA AUTONOMOUS_TRANSACTION;
t1 NUMBER ;
t2 number;
begin
  select count(*) into t1  from tuyenkenh_tieuchuan tt,tieuchuan tc where tt.tieuchuan_id=tc.id and tc.loaitieuchuan=1 and tuyenkenhdexuat_id=tuyenkenh_dexuat_id and tt.deleted=0 and tc.deleted=0;
  select count(*) into t2  from tieuchuan where loaitieuchuan=1 and deleted=0;
  t1:=t1/t2;
  if t1=1 then
    update tuyenkenhdexuat set trangthai=1 where id=tuyenkenh_dexuat_id;
  end if;
  return t1*100;
end get_tiendo;


--------------------------------------------------------
--  File created - Friday-October-05-2012   
--------------------------------------------------------
REM INSERTING into MENU
SET DEFINE OFF;
Insert into MENU (ID,NAMEMENU,ACTION,ACTIVE,IDROOTMENU) values (24,'Loại giao tiếp','/danhmuc/loaigiaotiep.action',1,8);
Insert into MENU (ID,NAMEMENU,ACTION,ACTIVE,IDROOTMENU) values (4,'Phòng ban','/danhmuc/phongban.action',1,8);
Insert into MENU (ID,NAMEMENU,ACTION,ACTIVE,IDROOTMENU) values (2,'Quản trị nhóm','/group/index.action',1,7);
Insert into MENU (ID,NAMEMENU,ACTION,ACTIVE,IDROOTMENU) values (3,'Quản trị quyền','/menu/index.action',1,7);
Insert into MENU (ID,NAMEMENU,ACTION,ACTIVE,IDROOTMENU) values (1,'Quản trị user','/user/index.action',1,7);
Insert into MENU (ID,NAMEMENU,ACTION,ACTIVE,IDROOTMENU) values (5,'Đối tác','/danhmuc/doitac.action',1,8);
Insert into MENU (ID,NAMEMENU,ACTION,ACTIVE,IDROOTMENU) values (6,'Dự án','/danhmuc/duan.action',1,8);
Insert into MENU (ID,NAMEMENU,ACTION,ACTIVE,IDROOTMENU) values (7,'Công thức','/danhmuc/congthuc.action',1,8);
Insert into MENU (ID,NAMEMENU,ACTION,ACTIVE,IDROOTMENU) values (8,'Tiêu chuẩn bàn giao kênh','/danhmuc/tieuchuan.action',1,8);
Insert into MENU (ID,NAMEMENU,ACTION,ACTIVE,IDROOTMENU) values (9,'Khu vực','/danhmuc/khuvuc.action',1,8);
Insert into MENU (ID,NAMEMENU,ACTION,ACTIVE,IDROOTMENU) values (10,'Quản lý tuyến kênh','/tuyenkenh/index.action',1,1);
Insert into MENU (ID,NAMEMENU,ACTION,ACTIVE,IDROOTMENU) values (11,'Import tuyến kênh','/import/tuyenkenh.action',1,1);
Insert into MENU (ID,NAMEMENU,ACTION,ACTIVE,IDROOTMENU) values (12,'Quản lý tiến độ bàn giao kênh','/tiendobangiao/index.action',1,1);
Insert into MENU (ID,NAMEMENU,ACTION,ACTIVE,IDROOTMENU) values (13,'Quản lý văn bản đề xuất',null,1,3);
Insert into MENU (ID,NAMEMENU,ACTION,ACTIVE,IDROOTMENU) values (14,'Quản lý biên bản bàn giao kênh','/bangiao/index.action',1,3);
Insert into MENU (ID,NAMEMENU,ACTION,ACTIVE,IDROOTMENU) values (15,'Quản lý biên bản vận hành kênh',null,1,3);
Insert into MENU (ID,NAMEMENU,ACTION,ACTIVE,IDROOTMENU) values (16,'Quản lý hợp đồng',null,1,4);
Insert into MENU (ID,NAMEMENU,ACTION,ACTIVE,IDROOTMENU) values (17,'Quản lý phụ lục hợp đồng',null,1,4);
Insert into MENU (ID,NAMEMENU,ACTION,ACTIVE,IDROOTMENU) values (18,'Báo cáo tiến độ',null,1,6);
Insert into MENU (ID,NAMEMENU,ACTION,ACTIVE,IDROOTMENU) values (19,'Xuất bảng đối soát cước',null,1,6);
Insert into MENU (ID,NAMEMENU,ACTION,ACTIVE,IDROOTMENU) values (20,'Báo cáo giảm trừ mất liên lạc',null,1,6);
Insert into MENU (ID,NAMEMENU,ACTION,ACTIVE,IDROOTMENU) values (21,'Báo cáo sự cố theo thời gian',null,1,6);
Insert into MENU (ID,NAMEMENU,ACTION,ACTIVE,IDROOTMENU) values (22,'SỰ CỐ KÊNH','/sucokenh/index.action',1,2);
Insert into MENU (ID,NAMEMENU,ACTION,ACTIVE,IDROOTMENU) values (23,'QUẢN LÝ HỒ SƠ TT','/thanhtoan/index.action',1,5);
Insert into MENU (ID,NAMEMENU,ACTION,ACTIVE,IDROOTMENU) values (25,'Đề xuất tuyến kênh','/tuyenkenhdexuat/index.action',1,1);
