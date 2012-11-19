package vms.db.dao;

import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.ResultSetMetaData;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Date;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;

import javax.sql.DataSource;


import oracle.jdbc.OracleTypes;

import org.apache.commons.lang3.StringUtils;
import org.springframework.jdbc.core.CallableStatementCreator;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.core.RowMapper;

import vms.db.dto.DoiTacDTO;
import vms.utils.Constances;
import vms.utils.DateUtils;
import vms.utils.VMSUtil;

public class LichSuTuyenKenhDAO {

	private JdbcTemplate jdbcTemplate;
	private DataSource jdbcDatasource;
	private DaoFactory daoFactory;
	public LichSuTuyenKenhDAO(DaoFactory daoFactory) {
		this.jdbcTemplate = daoFactory.getJdbcTemplate();
		this.jdbcDatasource = daoFactory.getJdbcDataSource();
		this.daoFactory = daoFactory;
	}
	
	public static Map<String, Object> resultSetToMap(ResultSet rs) throws SQLException {
    	Map<String, Object> map = VMSUtil.resultSetToMap(rs);
    	map.put("timeaction", DateUtils.formatDate(rs.getTimestamp("TIMEACTION"), DateUtils.SDF_DDMMYYYYHHMMSS2));
    	return map;
    	
    } 
	
	@SuppressWarnings("unchecked")
	public List<Map<String, Object>> findAll() {
		// TODO Auto-generated method stub
		return this.jdbcTemplate.query("select * from LICHSU_TUYENKENH", new RowMapper() {
			public Object mapRow(ResultSet rs, int rowNum)
					throws SQLException {
				return resultSetToMap(rs);
			}
		});
	}
	
	public void insertLichSu(String user, String tuyenkenh_id, int action, String moreInfo) {
		this.jdbcTemplate.update("call PROC_INSERT_LICHSU_TUYENKENH(?,?,?,?)", new Object[] {user,tuyenkenh_id, action,moreInfo});
	}
	
	private static final String SQL_FN_FIND_LICHSUTUYENKENH = "{ ? = call FN_FIND_LICHSUTUYENKENH(?,?,?) }";
	public List<Map<String,Object>> getData(int page,String tuyenkenh_id) throws SQLException {
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
