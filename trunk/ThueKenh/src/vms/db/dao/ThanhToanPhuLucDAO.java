package vms.db.dao;


import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import javax.sql.DataSource;
import oracle.jdbc.OracleTypes;

import org.springframework.jdbc.core.JdbcTemplate;

import vms.db.dto.HopDongDetailDTO;
import vms.db.dto.ThanhToanPhuLucDTO;

public class ThanhToanPhuLucDAO {
	private JdbcTemplate jdbcTemplate;
	private DataSource jdbcDatasource;
	public ThanhToanPhuLucDAO(DaoFactory daoFactory) {
		this.jdbcTemplate = daoFactory.getJdbcTemplate();
		this.jdbcDatasource = daoFactory.getJdbcDataSource();
	}
	
	public String save(ThanhToanPhuLucDTO dto) throws Exception {
		int count= this.jdbcTemplate.update("INSERT INTO THANHTOAN_PHULUC(THANHTOAN_ID,PHULUC_ID) VALUES ("+dto.getThanhtoan_id()+","+dto.getPhuluc_id()+")");
		return String.valueOf(count);
	}
	
	public void deletebythanhtoan_id(String thanhtoan_id) {
		this.jdbcTemplate.update("DELETE FROM THANHTOAN_PHULUC WHERE THANHTOAN_ID="+thanhtoan_id);
	}
	
	private static final String SQL_FIND_HOPDONG_BY_THANHTOAN_ID = "{ ? = call FN_FIND_HOPDONGBY_THANHTOAN(?) }";
	public List<HopDongDetailDTO> findHopDongByThanhToanId(String id) throws SQLException {
		Connection connection = jdbcDatasource.getConnection();
		CallableStatement stmt = connection.prepareCall(SQL_FIND_HOPDONG_BY_THANHTOAN_ID);
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
	
	private static final String SQL_FIND_PHULUC_BY_THANHTOAN_HOPDONG_ID = "{ ? = call FN_FIND_PHULUCBY_THANHTOAN(?,?) }";
	public List<String> findPhuLucByThanhToan_HopDong(String thanhtoan_id,String hopdong_id) throws SQLException {
		Connection connection = jdbcDatasource.getConnection();
		CallableStatement stmt = connection.prepareCall(SQL_FIND_PHULUC_BY_THANHTOAN_HOPDONG_ID);
		stmt.registerOutParameter(1, OracleTypes.CURSOR);
		stmt.setString(2, thanhtoan_id);
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
}
