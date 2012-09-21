/*
 * ============== Project : Software ==========================
 * Copyright (c) Lac Viet Cop.
 * 191A Hoang Van Thu, Phu Nhan Dist, Ho Chi Minh City, Viet Nam.
 * All rights reserved. 
 * This software is the confidential and proprietary information of Lac Viet Cop. 
 * ("Confidential Information"). You shall not disclose such Confidential Information 
 * and shall use it only in accordance with the terms of the license agreement 
 * you entered into with Lac Viet.
 * ===================================================================================
 */
package vms.utils;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;

public class DateUtils {
	
	public static SimpleDateFormat SDF_SQL = new SimpleDateFormat("dd-MMM-yyyy");
	public static SimpleDateFormat SDF_DDMMYYYY = new SimpleDateFormat("dd/MM/yyyy");
	public static SimpleDateFormat SDF_DDMMYYYYHHSS = new SimpleDateFormat("dd/MM/yyyy HH:ss");
	//private static SimpleDateFormat SDF_DDMMMYYYY = new SimpleDateFormat("dd-MMM-yyyy");
	
    public DateUtils() {
        super();
        // TODO Auto-generated constructor stub
    }
    public static Date parseDate(String str,String format) {
    	try {
    		SimpleDateFormat simpleDateFormat = new SimpleDateFormat(format);
			return simpleDateFormat.parse(str);
		} catch (ParseException e) {
			System.out.println("ERROR :" + e.getMessage());
		}
		return null;
    }
    public static String parseStringDateSQL(String str,String format) {
    	try {
    		SimpleDateFormat simpleDateFormat = new SimpleDateFormat(format);
			return SDF_SQL.format(simpleDateFormat.parse(str));
		} catch (ParseException e) {
			System.out.println("ERROR :" + e.getMessage());
		}
		return null;
    }
    public static String formatDate(Date date,SimpleDateFormat dateFormat) {
    	if(date == null) return "";
    	return dateFormat.format(date);
    }
    public static String parseToSQLDate(Date date) {
    	return SDF_SQL.format(date);
    }
    
    public static Date add(Date date,int type, int amount) {
    	Calendar calendar = Calendar.getInstance();
		calendar.setTime(date);
		calendar.add(type, amount);
		return calendar.getTime();
    }
    
    public static String getCurrentDateSQL() {
    	Calendar cal = Calendar.getInstance();
        return SDF_SQL.format(cal.getTime());
    }
	public static char[] SQLtoDisplay(String str, String string) {
		// TODO Auto-generated method stub
		return null;
	}
	public static java.sql.Date convertToSQLDate(Date date) {
		return new java.sql.Date(date.getTime());
	}
}

