package vms.utils;

import java.io.IOException;
import java.io.InputStream;
import java.io.StringWriter;
import java.sql.CallableStatement;
import java.sql.Connection;
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

import org.apache.commons.io.IOUtils;

import vms.db.dao.DaoFactory;

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
				String columnName = resultSetMetaData.getColumnName(i).toLowerCase();
				if(columnName.equals("dungluong")) {
					map.put(resultSetMetaData.getColumnName(i).toLowerCase(), rs.getDouble(i));
				} else {
					map.put(resultSetMetaData.getColumnName(i).toLowerCase(), rs.getString(i)==null?"":rs.getString(i));
				}
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
    
    public static String readStringInStream(InputStream inputStream) throws IOException {
    	StringWriter writer = new StringWriter();
		IOUtils.copy(inputStream, writer, "UTF-8");
		return writer.toString();
    }
    public static String cData(String str) {
    	return "<![CDATA["+str+"]]>";
    }
    public static String xml(String tagName,String value) {
    	return "<"+tagName+">"+value+"</"+tagName+">";
    }
    public static String resultSetToXML(ResultSet rs) {
    	StringBuffer buffer = new StringBuffer(512);
    	try {
			ResultSetMetaData resultSetMetaData = rs.getMetaData();
			int n = resultSetMetaData.getColumnCount();
			for(int i=1;i<=n;i++) {
				String tagName = resultSetMetaData.getColumnName(i).toLowerCase();
				String data = "";
				if(resultSetMetaData.getColumnType(i) == java.sql.Types.DATE) {
					data = DateUtils.formatDate(rs.getDate(i), DateUtils.SDF_DDMMYYYYHHMMSS3);
				} else {
					data = rs.getString(i)==null?"":rs.getString(i);
				}
				buffer.append("<"+tagName+">"+cData(data)+"</"+tagName+">");
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
    	return buffer.toString();
    	
    }
    
    public static String resultSetToXMLWithProperties(ResultSet rs) {
    	StringBuffer buffer = new StringBuffer(512);
    	try {
			ResultSetMetaData resultSetMetaData = rs.getMetaData();
			int n = resultSetMetaData.getColumnCount();
			for(int i=1;i<=n;i++) {
				String tagName = resultSetMetaData.getColumnName(i).toLowerCase();
				String data = "";
				if(resultSetMetaData.getColumnType(i) == java.sql.Types.DATE) {
					data = DateUtils.formatDate(rs.getDate(i), DateUtils.SDF_DDMMYYYYHHMMSS3);
				} else {
					data = rs.getString(i)==null?"":rs.getString(i);
					if(tagName.compareTo("trangthai")==0)
					{
						if(data.compareTo("0")==0)
							data="Không hoạt động";
						else if(data.compareTo("1")==0)
							data="Đang bàn giao";
						else if(data.compareTo("2")==0)
							data="Đang cập nhật số lượng";
						else if(data.compareTo("3")==0)
							data="Đã bàn giao";
						else if(data.compareTo("4")==0)
							data="Đang hoạt động";
					}
				}
				buffer.append("<cell hid=\""+tagName+"\" "+">"+cData(data)+"</cell>");
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
    	return buffer.toString();
    	
    }
    
    public static boolean checkLDAP(String userName,String Password) {
		//check LDAP
    	//if(true) return true;
		if(Password.equals(""))
        {
            return false;
        } else{
            //String ldapURL = Configuration.STR_LDAP_SERVER_URL;
        	String ldapURL = Constances.STR_LDAP_SERVER_URL;
            LdapHelper ldapHelper = new LdapHelper();
            ldapHelper.setLdapURL(ldapURL);
            return ldapHelper.checkValidUser(userName, Password);
        }
	}
    
    private static final String SQL_SENDMAIL = "{ call SEND_EMAIL(?,?,?) }";
    public static boolean sendMail(DaoFactory daoFactory, String tuyenkenhId, int type, String content){
    	try {
    		Connection connection = daoFactory.getDataSource().getConnection();
    		CallableStatement stmt = connection.prepareCall(SQL_SENDMAIL);
    		stmt.setString(1, tuyenkenhId);
    		stmt.setInt(2, type);
    		stmt.setString(3, content);
    		stmt.execute();
    		stmt.close();
    		connection.close();
		} catch (Exception e) {
			return false;
		}
    	return true;
    }
    private static final String SQL_SENDSMS = "{ call SEND_SMS(?,?,?) }";
    public static boolean sendSMS(DaoFactory daoFactory, String tuyenkenhId, int type, String content){
    	try {
    		Connection connection = daoFactory.getDataSource().getConnection();
    		CallableStatement stmt = connection.prepareCall(SQL_SENDSMS);
    		stmt.setString(1, tuyenkenhId);
    		stmt.setInt(2, type);
    		stmt.setString(3, content);
    		stmt.execute();
    		stmt.close();
    		connection.close();
		} catch (Exception e) {
			return false;
		}
    	return true;
    }
}
