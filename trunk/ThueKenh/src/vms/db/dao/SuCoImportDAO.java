package vms.db.dao;


import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.Map;

import javax.sql.DataSource;

import oracle.jdbc.OracleTypes;
import oracle.sql.ARRAY;
import oracle.sql.ArrayDescriptor;

import org.apache.commons.lang3.StringUtils;
import org.springframework.jdbc.core.JdbcTemplate;

import vms.db.dto.SuCoImportDTO;
import vms.db.dto.TuyenKenhImportDTO;
import vms.utils.DateUtils;
import vms.utils.VMSUtil;
import vms.web.models.FN_FIND_TUYENKENH;

public class SuCoImportDAO {
	private JdbcTemplate jdbcTemplate;
	private DataSource jdbcDatasource;
	public SuCoImportDAO(DaoFactory daoFactory) {
		this.jdbcTemplate = daoFactory.getJdbcTemplate();
		this.jdbcDatasource = daoFactory.getJdbcDataSource();
	}
	
	private static final String SQL_SAVE_SUCO_IMPORT = "{ call SAVE_SUCO_IMPORT(?,?,?,?,?,?,?,?,?) }";
	public void save(SuCoImportDTO dto) throws Exception {
		Connection connection = jdbcTemplate.getDataSource().getConnection();
		CallableStatement stmt = connection.prepareCall(SQL_SAVE_SUCO_IMPORT);
		stmt.setInt(1, dto.getStt());
		stmt.setString(2, dto.getMadiemdau());
		stmt.setString(3, dto.getMadiemcuoi());
		stmt.setString(4, dto.getMagiaotiep());
		stmt.setString(5, dto.getThoidiembatdau());
		stmt.setString(6, dto.getThoidiemketthuc());
		stmt.setString(7, dto.getNguyennhan());
		stmt.setString(8, dto.getPhuonganxuly());
		stmt.setString(9, dto.getTuyenkenh_id());
		stmt.execute();
		stmt.close();
		connection.close();
	}
	
	public void clear() {
		this.jdbcTemplate.execute("truncate table SUCO_IMPORT drop storage");
	}
	
	private static final String SQL_FIND_SUCOIMPORT = "{ ? = call FIND_SUCOIMPORT(?,?) }";
	public List<Map<String,Object>> search(int iDisplayStart,int iDisplayLength) throws SQLException {
		Connection connection = jdbcDatasource.getConnection();
		CallableStatement stmt = connection.prepareCall(SQL_FIND_SUCOIMPORT);
		stmt.registerOutParameter(1, OracleTypes.CURSOR);
		stmt.setInt(2, iDisplayStart);
		stmt.setInt(3, iDisplayLength);
		stmt.execute();
		ResultSet rs = (ResultSet) stmt.getObject(1);
		List<Map<String,Object>> result = new ArrayList<Map<String,Object>>();
		int i = 1;
		while(rs.next()) {
			Map<String,Object> map = VMSUtil.resultSetToMap(rs);
			map.put("stt", i);
			result.add(map);
			i++;
		}
		stmt.close();
		connection.close();
		return result;
	}
	
	private static final String SQL_PROC_IMPORT_TUYENKENH = "{ call PROC_IMPORT_TUYENKENH(?,?,?) }";
	public void importTuyenkenh(String[] ids,String account) throws SQLException {
		Connection connection = jdbcDatasource.getConnection();
		ArrayDescriptor descriptor = ArrayDescriptor.createDescriptor( "TABLE_NUMBER", connection );
		ARRAY array =new ARRAY( descriptor, connection, ids );
		CallableStatement stmt = connection.prepareCall(SQL_PROC_IMPORT_TUYENKENH);
		stmt.setArray(1, array);
		stmt.setString(2, account);
		stmt.setDate(3, DateUtils.convertToSQLDate(new Date()));
		stmt.execute();
		stmt.close();
		connection.close();
	}
	
	private static final String SQL_PROC_IMPORT_SUCO = "{ call PROC_IMPORT_SUCO(?,?,?) }";
	public void importSuCo(String[] ids,String account) throws SQLException {
		Connection connection = jdbcDatasource.getConnection();
		ArrayDescriptor descriptor = ArrayDescriptor.createDescriptor( "TABLE_NUMBER", connection );
		ARRAY array =new ARRAY( descriptor, connection, ids );
		CallableStatement stmt = connection.prepareCall(SQL_PROC_IMPORT_SUCO);
		stmt.setArray(1, array);
		stmt.setString(2, account);
		stmt.setDate(3, DateUtils.convertToSQLDate(new Date()));
		stmt.execute();
		stmt.close();
		connection.close();
	}
}