package vms.utils;

import java.sql.*;

import org.apache.tomcat.dbcp.dbcp.BasicDataSource;

public class ResourceManager {
	private static String JDBC_DRIVER   = "oracle.jdbc.driver.OracleDriver";
    private static String JDBC_URL      = "jdbc:oracle:thin:@192.168.1.105:1521:TEST";
    private static String JDBC_USER     = "THUEKENH";
    private static String JDBC_PASSWORD = "123456";
    private static Driver driver = null;
    private static Connection conn;
    //public static List<String> LIST_USER_LOGIN = new ArrayList();

    public static synchronized Connection connect() {
		try {
			if (conn == null || conn.isClosed()) {
				//System.out.println("CREATE NEW CONNECTION...");
				Class jdbcDriverClass = Class.forName(JDBC_DRIVER);
				driver = (Driver) jdbcDriverClass.newInstance();
				DriverManager.registerDriver(driver);
				conn = DriverManager.getConnection(JDBC_URL, JDBC_USER, JDBC_PASSWORD);
				System.out.println("USING NEW CONNECTION");
			} else {
				System.out.println("USING EXIST CONNECTION");
			}
		} catch (SQLException e) {
			System.out.println( "SQLException Error!" );
			e.printStackTrace();
		} catch(Exception ex){
			System.out.println( "Exception Error" );
			ex.printStackTrace();
		}
		return conn;
	}
    
    public static synchronized BasicDataSource getDataSource() {
    	
    	BasicDataSource dbcp = new BasicDataSource();
    	dbcp.setDriverClassName(JDBC_DRIVER);
    	dbcp.setUrl(JDBC_URL);
    	dbcp.setUsername(JDBC_USER);
    	dbcp.setPassword(JDBC_PASSWORD);
    	return dbcp;
    }
	/**
	 * close Method 
	 * @author :  
	 * Date : 11/15/2005 5:03:33 PM
	 */
	public static void close(Connection conn) { 
		try {
			if (conn != null) conn.close();
		}
		catch (SQLException sqle){
			sqle.printStackTrace();
		}
	}

	/**
	 * close Method 
	 * @author :      
	 * Date : 11/15/2005 5:03:33 PM
	 */
	public static void close(PreparedStatement stmt){
		try {
			if (stmt != null) stmt.close();
		}
		catch (SQLException sqle){
			sqle.printStackTrace();
		}
	}

	/**
	 * close Method 
	 * @author :      
	 * Date : 11/15/2005 5:03:33 PM
	 */
	public static void close(ResultSet rs) { 
		try {
			if (rs != null) rs.close();
		}
		catch (SQLException sqle){
			sqle.printStackTrace();
		}
	}
	 public static void main(String[] arg){
		 
	 }
}