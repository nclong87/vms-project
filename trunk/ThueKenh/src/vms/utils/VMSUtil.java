package vms.utils;

import java.io.IOException;
import java.sql.ResultSet;
import java.sql.ResultSetMetaData;
import java.sql.SQLException;
import java.util.Enumeration;
import java.util.LinkedHashMap;
import java.util.Map;

import javax.script.ScriptEngine;
import javax.script.ScriptEngineManager;
import javax.script.ScriptException;
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
    public static String getUploadFolder() throws IOException {
		return new java.io.File("..").getCanonicalPath()+Constances.DS+"webapps"+Constances.DS+"upload"+Constances.DS;
	}
    public static String getUploadImportFolder() throws IOException {
		return new java.io.File("..").getCanonicalPath()+Constances.DS+"webapps"+Constances.DS+"upload"+Constances.DS+"import"+Constances.DS;
	}
    
    public static LinkedHashMap<String, Object> json_success(Map<String, Object> data) {
    	 LinkedHashMap<String, Object> rs = new LinkedHashMap<String, Object>();
    	 rs.put("type", 1);
    	 rs.put("data", data);
    	return rs;
    }
    
    public static LinkedHashMap<String, Object> json_error(Map<String, Object> data) {
   	 LinkedHashMap<String, Object> rs = new LinkedHashMap<String, Object>();
   	 rs.put("type", 0);
   	 rs.put("data", data);
   	return rs;
   }
    
    public static Map<String, Object> resultSetToMap(ResultSet rs) {
    	Map<String, Object> map = new LinkedHashMap<String, Object>();
    	try {
			ResultSetMetaData resultSetMetaData = rs.getMetaData();
			int n = resultSetMetaData.getColumnCount();
			for(int i=1;i<=n;i++) {
				map.put(resultSetMetaData.getColumnName(i).toLowerCase(), rs.getString(i)==null?"":rs.getString(i));
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
    	return map;
    	
    }
    
    public static double calculate(String exp) {
    	ScriptEngineManager mgr = new ScriptEngineManager();
        ScriptEngine engine = mgr.getEngineByName("JavaScript");
        try {
			return (Double) engine.eval(exp);
		} catch (ScriptException e) {
			e.printStackTrace();
		}
        return 0;
    }
    
    public static String replacements(String strIn,String[][] replacements) {
    	/*String[][] replacements = {{"DG", "123"}, 
                {"SL", "4"}};*/
		String strOutput = strIn;
		for(String[] replacement: replacements) {
		strOutput = strOutput.replace(replacement[0], replacement[1]);
		}
		return strOutput;
    }
}
