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
import vms.db.dto.HopDongDetailDTO;
import vms.db.dto.Menu;
import vms.db.dto.PhuLucDTO;
import vms.utils.DateUtils;
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
	
	public void updateDoiSoatCuoc(String tendoisoatcuoc,String doisoatcuoc_id) throws Exception {
		int nDuplicateName = this.jdbcTemplate.queryForInt("select count(*) as NUM from DOISOATCUOC where DELETED = 0 and TENDOISOATCUOC = ?", new Object[] {tendoisoatcuoc});
		if(nDuplicateName > 0) throw new Exception("DUPLICATE");
		String query = "update DOISOATCUOC set TENDOISOATCUOC = ?, DELETED = 0 where ID = ?";
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
	
	private static final String SQL_FIND_DOISOATCUOC = "{ ? = call FIND_DOISOATCUOC(?,?,?,?) }";
	public List<Map<String,Object>> search(int iDisplayStart,int iDisplayLength,Map<String, String> conditions) throws SQLException {
		Connection connection = jdbcDatasource.getConnection();
		CallableStatement stmt = connection.prepareCall(SQL_FIND_DOISOATCUOC);
		stmt.registerOutParameter(1, OracleTypes.CURSOR);
		stmt.setInt(2, iDisplayStart);
		stmt.setInt(3, iDisplayLength);
		stmt.setString(4, conditions.get("id"));
		stmt.setString(5, conditions.get("tenbangdoisoatcuoc"));
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
	private static final String SQL_FIND_HOPDONG_BY_DOISOATCUOC_ID = "{ ? = call FN_FIND_HOPDONGBY_DSCUOC(?) }";
	public List<HopDongDetailDTO> findHopDongByDoiSoatCuocId(String id) throws SQLException {
		Connection connection = jdbcDatasource.getConnection();
		CallableStatement stmt = connection.prepareCall(SQL_FIND_HOPDONG_BY_DOISOATCUOC_ID);
		stmt.registerOutParameter(1, OracleTypes.CURSOR);
		stmt.setString(2, id);
		stmt.execute();
		ResultSet rs = (ResultSet) stmt.getObject(1);
		List<HopDongDetailDTO> result = new ArrayList<HopDongDetailDTO>();
		while (rs.next()) {
			result.add(HopDongDetailDTO.mapObject(rs));
		}
		stmt.close();
		connection.close();
		return result;
	}
	
	
	private static final String SQL_FIND_PHULUC_BY_DOISOATCUOC_HOPDONG_ID = "{ ? = call FN_FIND_PHULUCBY_DSCUOC_HD(?,?) }";
	public List<String> findPhuLucByDoiSoatCuoc_HopDong(String doisoatcuoc_id,String hopdong_id) throws SQLException {
		Connection connection = jdbcDatasource.getConnection();
		CallableStatement stmt = connection.prepareCall(SQL_FIND_PHULUC_BY_DOISOATCUOC_HOPDONG_ID);
		stmt.registerOutParameter(1, OracleTypes.CURSOR);
		stmt.setString(2, doisoatcuoc_id);
		stmt.setString(3,hopdong_id);
		stmt.execute();
		ResultSet rs = (ResultSet) stmt.getObject(1);
		List<String> result = new ArrayList<String>();
		while (rs.next()) {
			result.add(rs.getString("PHULUC_ID"));
		}
		stmt.close();
		connection.close();
		return result;
	}
	
	@SuppressWarnings("unchecked")
	public Map<String,Object> findById(String id) {
		return (Map<String,Object>) this.jdbcTemplate.queryForObject("select t.*,t1.TENDOITAC from DOISOATCUOC t left join DOITAC t1 on t.DOITAC_ID = t1.ID where t.id = ?" ,new Object[] {id}, new RowMapper() {
			@Override
			public Object mapRow(ResultSet rs, int arg1) throws SQLException {
				Map<String,Object> map = VMSUtil.resultSetToMap(rs);
				map.put("tungay",DateUtils.formatDate(rs.getDate("TUNGAY"), DateUtils.SDF_DDMMYYYY));
				map.put("denngay",DateUtils.formatDate(rs.getDate("DENNGAY"), DateUtils.SDF_DDMMYYYY));
				map.put("matlienlactu",DateUtils.formatDate(rs.getDate("MATLIENLACTU"), DateUtils.SDF_MMYYYY));
				map.put("matlienlacden",DateUtils.formatDate(rs.getDate("MATLIENLACDEN"), DateUtils.SDF_MMYYYY));
				return map;
			}
		});
	}
}