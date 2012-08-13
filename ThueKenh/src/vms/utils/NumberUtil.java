package vms.utils;

import java.math.BigDecimal;




public class NumberUtil {
	public static int intValue(Object value) {
		if(value == null) 
			return 0;
		return ((BigDecimal)value).intValue();
	}
	public static long longValue(Object value) {
		if(value == null) 
			return 0;
		return ((BigDecimal)value).longValue();
	}
	public static int parseInt(String value) {
		try {
			return Integer.parseInt(value);
		} catch (Exception e) {
			return 0;
		}
	}
	public static long parseLong(String value) {
		try {
			return Long.parseLong(value);
		} catch (Exception e) {
			return 0;
		}
	}
	public static void main(String arg[]) {
		//String src ="  Toi  a ha   Long    ";
		//src.equals(arg0)
		//System.out.println("src.md5="+MD5(src));
    }
}