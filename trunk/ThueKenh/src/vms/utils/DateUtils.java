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
	public static SimpleDateFormat SDF_DDMMYYYYHHMMSS = new SimpleDateFormat("dd-MMM-yyyy HH:mm:ss");
	public static SimpleDateFormat SDF_DDMMYYYYHHMMSS2 = new SimpleDateFormat("dd/MM/yyyy HH:mm:ss");
	public static SimpleDateFormat SDF_DDMMYYYYHHMMSS3 = new SimpleDateFormat("yyyy-MM-dd'T'HH:mm:ss.SSS");
	public static SimpleDateFormat SDF_MMYYYY = new SimpleDateFormat("MM/yyyy");
	public static SimpleDateFormat SDF_HHMMSS = new SimpleDateFormat("HH:mm:ss");
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
			System.out.println("ERROR parseDate :" + e.getMessage());
		}
		return null;
    }
    public static String parseStringDateSQL(String str,String format) {
    	try {
    		SimpleDateFormat simpleDateFormat = new SimpleDateFormat(format);
			return SDF_SQL.format(simpleDateFormat.parse(str));
		} catch (ParseException e) {
			System.out.println("ERROR parseStringDateSQL :" + e.getMessage());
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
	
	// created by toannguyenb
	// Compare Date
	public static Integer compareDate(Date date1, Date date2){
		try
		{
	        if (date1.equals(date2)) // bang nhau
	        	return 0;
	        else if (date1.before(date2)) // date1 < date2
	        	return 1;
	        else if (date1.after(date2))
	          return -1; // date1 > date2
		}catch (Exception ex) {
			System.out.println("ERROR compareDate :" + ex.getMessage());
			return -2;
		}
		return null;
    }
	public static java.sql.Date convert(Date date) {
		return new java.sql.Date(date.getTime());
	}
	public static java.sql.Date convertToSQLDate(Date date) {
		return new java.sql.Date(date.getTime());
	}
	public static java.sql.Date parseToSQLDate(String sDate,String format) {
		if(format == null) format = "dd/MM/yyyy";
		return DateUtils.convertToSQLDate(DateUtils.parseDate(sDate, format));
	}
}

