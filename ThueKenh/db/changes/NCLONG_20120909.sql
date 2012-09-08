create or replace
FUNCTION            "GETLISTMENU" (
idaccount_ in number,
idgroup_ in varchar2
) RETURN CLOB AS 
----========================================================================
-- @project: VMS quan ly kenh truyen dan
-- @description: Lay danh sach menu cua user, tra ve dang chuoi HTML
-- @author	nclong
-- @date Feb 16, 2012
-- @param
-- @vesion 1.0
-- @copyright nclong
---- @date update 
---- @user update
---- @note: 
----========================================================================
TYPE table_menu_bulk IS TABLE OF MENU%ROWTYPE;
tableMenu table_menu_bulk := table_menu_bulk();
vc_sql varchar2(2000);
clob_return clob;
vc_tmp varchar2(4000);
num number;
BEGIN
	clob_return := '<ul class="sf-menu">';
	vc_sql:= 'select m.* from menu m,user_menu u where m.active = 1 and m.id=u.menuid and accountid='||idaccount_||' union select t3.* from group_menu t1,vmsgroup t2,menu t3 where t1.idmenu=t3.id and t1.idgroup=t2.id  and t2.active=1 and t2.id='''||idgroup_||''' ';
	EXECUTE IMMEDIATE vc_sql BULK COLLECT INTO tableMenu ; 
  if(tableMenu.count()>0) then
	for rec in (select ID,NAME from ROOTMENU) loop
		vc_tmp := null;
    num := 0;
		for n in tableMenu.first .. tableMenu.last loop
			if(rec.ID = tableMenu(n).IDROOTMENU) then
				--DBMS_LOB.append (clob_return,'<li>');
				vc_tmp := vc_tmp||'<li><a href="#" onclick="loadContent('''||tableMenu(n).ACTION||''')">'||tableMenu(n).NAMEMENU||'</a></li>';
        num := num + 1;
      end if;
			--DBMS_OUTPUT.PUT_LINE(tableMenu(n).NAMEMENU);
		end loop;
		
		if(num > 1) then 
			vc_tmp := '<li><a href="#a">'||rec.NAME||'</a><ul>'||vc_tmp||'</ul></li>';
			DBMS_LOB.append (clob_return,vc_tmp);
    elsif (num = 1) then
      DBMS_LOB.append (clob_return,vc_tmp);
		end if;
	end loop;
  end if;
	DBMS_LOB.append (clob_return,'</ul>');
	--DBMS_OUTPUT.PUT_LINE(clob_return);
	RETURN clob_return;
END GETLISTMENU;

--------------------------------------------------------
--  File created - Sunday-September-09-2012   
--------------------------------------------------------
REM INSERTING into THUEKENH.MENU
Insert into THUEKENH.MENU (ID,NAMEMENU,ACTION,ACTIVE,IDROOTMENU) values (4,'Phòng ban','/danhmuc/phongban.action',1,8);
Insert into THUEKENH.MENU (ID,NAMEMENU,ACTION,ACTIVE,IDROOTMENU) values (2,'Quản trị nhóm','/group/index.action',1,7);
Insert into THUEKENH.MENU (ID,NAMEMENU,ACTION,ACTIVE,IDROOTMENU) values (3,'Quản trị quyền','/menu/index.action',1,7);
Insert into THUEKENH.MENU (ID,NAMEMENU,ACTION,ACTIVE,IDROOTMENU) values (1,'Quản trị user','/user/index.action',1,7);
Insert into THUEKENH.MENU (ID,NAMEMENU,ACTION,ACTIVE,IDROOTMENU) values (5,'Đối tác','/danhmuc/doitac.action',1,8);
Insert into THUEKENH.MENU (ID,NAMEMENU,ACTION,ACTIVE,IDROOTMENU) values (6,'Dự án','/danhmuc/duan.action',1,8);
Insert into THUEKENH.MENU (ID,NAMEMENU,ACTION,ACTIVE,IDROOTMENU) values (7,'Loại dự cố','/danhmuc/phongban.action',1,8);
Insert into THUEKENH.MENU (ID,NAMEMENU,ACTION,ACTIVE,IDROOTMENU) values (8,'Tiêu chí bàn giao kênh','/danhmuc/phongban.action',1,8);
Insert into THUEKENH.MENU (ID,NAMEMENU,ACTION,ACTIVE,IDROOTMENU) values (9,'Khu vực','/danhmuc/khuvuc.action',1,8);
Insert into THUEKENH.MENU (ID,NAMEMENU,ACTION,ACTIVE,IDROOTMENU) values (10,'Quản lý tuyến kênh','/tuyenkenh/index.action',1,1);
Insert into THUEKENH.MENU (ID,NAMEMENU,ACTION,ACTIVE,IDROOTMENU) values (11,'Import tuyến kênh','/import/tuyenkenh.action',1,1);
Insert into THUEKENH.MENU (ID,NAMEMENU,ACTION,ACTIVE,IDROOTMENU) values (12,'Quản lý tiến độ bàn giao kênh','/bangiao/index.action',1,1);
Insert into THUEKENH.MENU (ID,NAMEMENU,ACTION,ACTIVE,IDROOTMENU) values (13,'Quản lý văn bản đề xuất',null,1,3);
Insert into THUEKENH.MENU (ID,NAMEMENU,ACTION,ACTIVE,IDROOTMENU) values (14,'Quản lý biên bản bàn giao kênh',null,1,3);
Insert into THUEKENH.MENU (ID,NAMEMENU,ACTION,ACTIVE,IDROOTMENU) values (15,'Quản lý biên bản vận hành kênh',null,1,3);
Insert into THUEKENH.MENU (ID,NAMEMENU,ACTION,ACTIVE,IDROOTMENU) values (16,'Quản lý hợp đồng',null,1,4);
Insert into THUEKENH.MENU (ID,NAMEMENU,ACTION,ACTIVE,IDROOTMENU) values (17,'Quản lý phụ lục hợp đồng',null,1,4);
Insert into THUEKENH.MENU (ID,NAMEMENU,ACTION,ACTIVE,IDROOTMENU) values (18,'Báo cáo tiến độ',null,1,6);
Insert into THUEKENH.MENU (ID,NAMEMENU,ACTION,ACTIVE,IDROOTMENU) values (19,'Xuất bảng đối soát cước',null,1,6);
Insert into THUEKENH.MENU (ID,NAMEMENU,ACTION,ACTIVE,IDROOTMENU) values (20,'Báo cáo giảm trừ mất liên lạc',null,1,6);
Insert into THUEKENH.MENU (ID,NAMEMENU,ACTION,ACTIVE,IDROOTMENU) values (21,'Báo cáo sự cố theo thời gian',null,1,6);
Insert into THUEKENH.MENU (ID,NAMEMENU,ACTION,ACTIVE,IDROOTMENU) values (22,'SỰ CỐ KÊNH','/sucokenh/index.action',1,2);
Insert into THUEKENH.MENU (ID,NAMEMENU,ACTION,ACTIVE,IDROOTMENU) values (23,'QUẢN LÝ HỒ SƠ TT','/thanhtoan/index.action',1,5);




--------------------------------------------------------
--  File created - Sunday-September-09-2012   
--------------------------------------------------------
ALTER TABLE ROOTMENU 
ADD (URL VARCHAR2(200) );

REM INSERTING into THUEKENH.ROOTMENU
Insert into THUEKENH.ROOTMENU (ID,NAME) values (1,'TUYẾN KÊNH');
Insert into THUEKENH.ROOTMENU (ID,NAME) values (2,'SỰ CỐ KÊNH');
Insert into THUEKENH.ROOTMENU (ID,NAME) values (3,'QUẢN LÝ VĂN BẢN');
Insert into THUEKENH.ROOTMENU (ID,NAME) values (4,'QUẢN LÝ HỢP ĐỒNG');
Insert into THUEKENH.ROOTMENU (ID,NAME) values (5,'QUẢN LÝ HỒ SƠ TT');
Insert into THUEKENH.ROOTMENU (ID,NAME) values (6,'HỆ THỐNG BÁO CÁO');
Insert into THUEKENH.ROOTMENU (ID,NAME) values (7,'QUẢN TRỊ');
Insert into THUEKENH.ROOTMENU (ID,NAME) values (8,'DANH  MỤC');

--------------------------------------------------------
--  File created - Sunday-September-09-2012   
--------------------------------------------------------
REM INSERTING into THUEKENH.GROUP_MENU
Insert into THUEKENH.GROUP_MENU (IDGROUP,IDMENU) values (1,1);
Insert into THUEKENH.GROUP_MENU (IDGROUP,IDMENU) values (1,2);
Insert into THUEKENH.GROUP_MENU (IDGROUP,IDMENU) values (1,3);
Insert into THUEKENH.GROUP_MENU (IDGROUP,IDMENU) values (1,4);
Insert into THUEKENH.GROUP_MENU (IDGROUP,IDMENU) values (1,5);
Insert into THUEKENH.GROUP_MENU (IDGROUP,IDMENU) values (1,6);
Insert into THUEKENH.GROUP_MENU (IDGROUP,IDMENU) values (1,7);
Insert into THUEKENH.GROUP_MENU (IDGROUP,IDMENU) values (1,8);
Insert into THUEKENH.GROUP_MENU (IDGROUP,IDMENU) values (1,9);
Insert into THUEKENH.GROUP_MENU (IDGROUP,IDMENU) values (1,10);
Insert into THUEKENH.GROUP_MENU (IDGROUP,IDMENU) values (1,11);
Insert into THUEKENH.GROUP_MENU (IDGROUP,IDMENU) values (1,12);
Insert into THUEKENH.GROUP_MENU (IDGROUP,IDMENU) values (1,13);
Insert into THUEKENH.GROUP_MENU (IDGROUP,IDMENU) values (1,14);
Insert into THUEKENH.GROUP_MENU (IDGROUP,IDMENU) values (1,15);
Insert into THUEKENH.GROUP_MENU (IDGROUP,IDMENU) values (1,16);
Insert into THUEKENH.GROUP_MENU (IDGROUP,IDMENU) values (1,17);
Insert into THUEKENH.GROUP_MENU (IDGROUP,IDMENU) values (1,18);
Insert into THUEKENH.GROUP_MENU (IDGROUP,IDMENU) values (1,19);
Insert into THUEKENH.GROUP_MENU (IDGROUP,IDMENU) values (1,20);
Insert into THUEKENH.GROUP_MENU (IDGROUP,IDMENU) values (1,21);
Insert into THUEKENH.GROUP_MENU (IDGROUP,IDMENU) values (1,22);
Insert into THUEKENH.GROUP_MENU (IDGROUP,IDMENU) values (1,23);
Insert into THUEKENH.GROUP_MENU (IDGROUP,IDMENU) values (2,1);
Insert into THUEKENH.GROUP_MENU (IDGROUP,IDMENU) values (2,2);
Insert into THUEKENH.GROUP_MENU (IDGROUP,IDMENU) values (3,2);
Insert into THUEKENH.GROUP_MENU (IDGROUP,IDMENU) values (4,2);


