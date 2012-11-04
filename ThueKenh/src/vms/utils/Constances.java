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

import java.io.IOException;

public class Constances {
	public static String DEFAULT_HOME_PAGE = "/index/index.action";
	public static String SESS_USERLOGIN = "SESS_USERLOGIN";
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
}
