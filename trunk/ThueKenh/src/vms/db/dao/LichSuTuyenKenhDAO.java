package vms.db.dao;

import java.io.IOException;
import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import javax.sql.DataSource;


import oracle.jdbc.OracleTypes;

import org.springframework.jdbc.core.JdbcTemplate;
import org.xml.sax.SAXException;

import vms.utils.Constances;
import vms.utils.DateUtils;
import vms.utils.VMSUtil;
import vms.utils.XMLUtil;

public class LichSuTuyenKenhDAO {

	private JdbcTemplate jdbcTemplate;
	private DataSource jdbcDatasource;
	@SuppressWarnings("unused")
	private DaoFactory daoFactory;
	public LichSuTuyenKenhDAO(DaoFactory daoFactory) {
		this.jdbcTemplate = daoFactory.getJdbcTemplate();
		this.jdbcDatasource = daoFactory.getJdbcDataSource();
		this.daoFactory = daoFactory;
	}
	
	public static Map<String, Object> resultSetToMap(ResultSet rs) throws SQLException, SAXException, IOException {
    	Map<String, Object> map = VMSUtil.resultSetToMap(rs);
    	map.put("timeaction", DateUtils.formatDate(rs.getTimestamp("TIMEACTION"), DateUtils.SDF_DDMMYYYYHHMMSS2));
    	if(rs.getString("INFO") != null) {
	    	List<Map<String, String>> list = XMLUtil.parseXMLString(rs.getString("INFO"));
	    	map.put("info", list);
    	}
    	return map;
    	
    } 
	
	
	public void insertLichSu(String user, String tuyenkenh_id, int action, String moreInfo) {
		this.jdbcTemplate.update("call PROC_INSERT_LICHSU_TUYENKENH(?,?,?,?)", new Object[] {user,tuyenkenh_id, action,moreInfo});
	}
	
	private static final String SQL_FN_FIND_LICHSUTUYENKENH = "{ ? = call FN_FIND_LICHSUTUYENKENH(?,?,?) }";
	public List<Map<String,Object>> getData(int page,String tuyenkenh_id) throws SQLException, SAXException, IOException {
		int iDisplayStart = page * Constances.LS_MAX_PAGE_LENGHT;
		Connection connection = jdbcDatasource.getConnection();
		CallableStatement stmt = connection.prepareCall(SQL_FN_FIND_LICHSUTUYENKENH);
		stmt.registerOutParameter(1, OracleTypes.CURSOR);
		stmt.setInt(2, iDisplayStart);
		stmt.setInt(3, Constances.LS_MAX_PAGE_LENGHT);
		stmt.setString(4, tuyenkenh_id);
		stmt.execute();
		ResultSet rs = (ResultSet) stmt.getObject(1);
		List<Map<String,Object>> result = new ArrayList<Map<String,Object>>();
		while(rs.next()) {
			result.add(resultSetToMap(rs));
		}
		stmt.close();
		connection.close();
		return result;
	}

}
