/*
 * ============== Project : 1080 Information Software ==========================
 * Copyright (c) Lac Viet Cop.
 * 23 NguyÃªÌƒn Thá»‹ Huá»³nh (76/23 NguyÃªÌƒn VÄƒn TrÃ´Ìƒi), P.8, Q.PhÃº Nhuáº­n, Tp.HCM.
 * All rights reserved. 
 * This software is the confidential and proprietary information of Lac Viet Cop. 
 * ("Confidential Information"). You shall not disclose such Confidential Information 
 * and shall use it only in accordance with the terms of the license agreement 
 * you entered into with Lac Viet.
 * ===================================================================================
 */
package vms.utils;

public class Constances {
	public static String DEFAULT_HOME_PAGE = "/index/index.action";
	public static String SESS_USERLOGIN = "SESS_USERLOGIN";
	public static String SESS_MENUIDS = "SESS_MENUIDS";
	public static String SESS_MENU = "SESS_MENU";
	public static String OK = "OK";
	public static String ERROR = "ERROR";
	public static String ACCOUNT_EXIST = "ACCOUNT_EXIST";
	public static String END_SESSION = "END_SESSION";
	
	public static String MSG_LOGINFAIL = "Đăng nhập thất bại, vui lòng thử lại";
	public static String MSG_ERROR = "Có lỗi xảy ra, vui lòng thử lại";
	public static String MSG_SUCCESS = "Lưu dữ liệu thành công!";
	public static String DS = System.getProperty("file.separator");
	
	// Cong thuc
	public static String CUOCONG = "CC";
	public static String DONGIA = "DG";
	public static String SOLUONG = "SL";
	
	//Phu luc
	public static int PHU_LUC_DOC_LAP = 1;
	public static int PHU_LUC_THAY_THE = 2;
	
	//LDAP
	//public static final String STR_LDAP_SERVER_URL		= "ldap://10.151.70.249:389/ou=system";
	public static final String STR_LDAP_SERVER_URL		= "ldap://vms.com.vn";
	
	//Lich su
	public static int LS_MAX_PAGE_LENGHT = 10;
	
	//Menu
	public static final int QUAN_LY_USER = 1;
	public static final int QUAN_LY_NHOM = 2;
	public static final int QUAN_LY_QUYEN = 3;
	public static final int QUAN_LY_PHONGBAN = 4;
	public static final int QUAN_LY_DOITAC = 5;
	public static final int QUAN_LY_DUAN = 6;
	public static final int QUAN_LY_CACHTINHCUOC = 7;
	public static final int QUAN_LY_TIEUCHUANBANGIAO = 8;
	public static final int QUAN_LY_KHUVUC = 9;
	public static final int QUAN_LY_TUYEN_KENH = 10;
	public static final int IMPORT_TUYENKENH = 11;
	public static final int QUAN_LY_TIENDOBANGIAO = 12;
	public static final int QUAN_LY_VANBANDEXUAT = 13;
	public static final int QUAN_LY_BIENBANBANGIAO = 14;
	public static final int QUAN_LY_BIENBANVANHANH = 15;
	public static final int QUAN_LY_HOPDONG = 16;
	public static final int QUAN_LY_PHULUC = 17;
	public static final int BAOCAO_TIENDO = 18;
	public static final int BAOCAO_DOISOATCUOC = 19;
	public static final int BAOCAO_GIAMTRUMLL = 20;
	public static final int BAOCAO_SUCOTHEOTHOIGIAN = 21;
	public static final int QUAN_LY_SUCOKENH = 22;
	public static final int QUAN_LY_HOSOTHANHTOAN = 23;
	public static final int QUAN_LY_LOAIGIAOTIEP = 24;
	public static final int QUAN_LY_DEXUATTUYENKENH = 25;
	public static final int QUAN_LY_TRAMDAUCUOI = 26;
}
