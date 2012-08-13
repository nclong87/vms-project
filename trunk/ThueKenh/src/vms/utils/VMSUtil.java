package vms.utils;

import java.util.Enumeration;
import java.util.LinkedHashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

public class VMSUtil {
    @SuppressWarnings("unchecked")
	public static Map<String, String> getMap(HttpServletRequest request) {
    	Enumeration<String> enumeration = request.getParameterNames();
    	Map<String, String> map = new LinkedHashMap<String, String>();
    	while(enumeration.hasMoreElements()) {
    		String key = enumeration.nextElement();
    		String value = request.getParameter(key);
    		map.put(key, value);
    	}
    	return map;
    }
    
    public static String getFullURL(HttpServletRequest request) {
		String str = request.getQueryString();
		if(str == null) 
			return request.getRequestURL().toString();
		else
			return request.getRequestURL().append("?").append(request.getQueryString()).toString();
	}
}
