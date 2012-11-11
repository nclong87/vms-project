package vms.db.dao;


import java.sql.CallableStatement;
import java.sql.Clob;
import java.sql.Connection;
import java.sql.Date;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import javax.sql.DataSource;

import oracle.jdbc.OracleTypes;
import oracle.sql.ARRAY;
import oracle.sql.ArrayDescriptor;

import org.apache.commons.lang3.StringUtils;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.core.RowMapper;
import vms.db.dto.Account;
import vms.db.dto.Menu;
import vms.utils.StringUtil;
import vms.utils.VMSUtil;

public class DoiSoatCuocDAO {
	private JdbcTemplate jdbcTemplate;
	private DataSource jdbcDatasource;
	private Connection connection;
	public DoiSoatCuocDAO(Connection conn) {
		connection = conn;
	}
	public DoiSoatCuocDAO(DaoFactory daoFactory) {
		this.jdbcTemplate = daoFactory.getJdbcTemplate();
		this.jdbcDatasource = daoFactory.getJdbcDataSource();
	}
	
	//private static final String PROC_BC_DOISOATCUOC = "{ call BC_DOISOATCUOC(?,?,?,?,?,?) }";
	private static final String SQL_FN_SAVEDOISOATCUOC = "{ ? = call FN_SAVEDOISOATCUOC(?,?,?,?,?,?) }";
	public Map<String,Object> saveDoiSoatCuoc(String doitac_id,Date sqlTuNgay,Date sqlDenNgay,String[] phulucs, String[] sucos) throws Exception {
		if(connection == null)
			connection = this.jdbcDatasource.getConnection();
		System.out.println("***BEGIN saveDoiSoatCuoc***");
		ArrayDescriptor descriptor = ArrayDescriptor.createDescriptor( "TABLE_VARCHAR", connection );
		ARRAY arrPhuLuc =new ARRAY( descriptor, connection, phulucs );
		ARRAY arrSuCo =new ARRAY( descriptor, connection, sucos );
		CallableStatement stmt = connection.prepareCall(SQL_FN_SAVEDOISOATCUOC);
		stmt.registerOutParameter(1, OracleTypes.CURSOR);
		stmt.setString(2, doitac_id);
		stmt.setDate(3, sqlTuNgay);
		stmt.setDate(4, sqlDenNgay);
		stmt.setArray(5, arrPhuLuc);
		stmt.setArray(6, arrSuCo);
		stmt.setLong(7, System.currentTimeMillis());
		stmt.execute();
		ResultSet rs = (ResultSet) stmt.getObject(1);
		rs.next();
		Map<String,Object> result = VMSUtil.resultSetToMap(rs);
		stmt.close();
		connection.close();
		return result;
	}
	
	public void updateDoiSoatCuoc(String tendoisoatcuoc,String doisoatcuoc_id) {
		String query = "update DOISOATCUOC set TENDOISOATCUOC = ? where ID = ?";
		this.jdbcTemplate.update(query,new Object[] {tendoisoatcuoc,doisoatcuoc_id});
	}
	
	private static final String SQL_PROC_REMOVE_DOISOATCUOC = "{ call PROC_REMOVE_DOISOATCUOC(?) }";
	public void deleteDoiSoatCuoc(String doisoatcuoc_id) throws SQLException {
		if(connection == null)
			connection = this.jdbcDatasource.getConnection();
		System.out.println("***BEGIN deleteDoiSoatCuoc***");
		CallableStatement stmt = connection.prepareCall(SQL_PROC_REMOVE_DOISOATCUOC);
		stmt.setString(1, doisoatcuoc_id);
		stmt.execute();
		stmt.close();
		connection.close();
	}
}