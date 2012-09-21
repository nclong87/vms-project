package vms.db.dao;


import java.sql.CallableStatement;
import java.sql.Connection;
import javax.sql.DataSource;

import org.springframework.jdbc.core.JdbcTemplate;

import vms.db.dto.TuyenKenhImportDTO;
import vms.utils.DateUtils;

public class TuyenkenhImportDAO {
	private JdbcTemplate jdbcTemplate;
	private DataSource jdbcDatasource;
	public TuyenkenhImportDAO(DaoFactory daoFactory) {
		this.jdbcTemplate = daoFactory.getJdbcTemplate();
		this.jdbcDatasource = daoFactory.getJdbcDataSource();
	}
	
	private static final String SQL_SAVE_TUYENKENH_IMPORT = "{ call SAVE_TUYENKENH_IMPORT(?,?,?,?,?,?,?,?,?,?) }";
	public void save(TuyenKenhImportDTO dto) throws Exception {
		Connection connection = jdbcTemplate.getDataSource().getConnection();
		CallableStatement stmt = connection.prepareCall(SQL_SAVE_TUYENKENH_IMPORT);
		stmt.setInt(1, dto.getStt());
		stmt.setString(2, dto.getMadiemdau());
		stmt.setString(3, dto.getMadiemcuoi());
		stmt.setString(4, dto.getGiaotiep_ma());
		stmt.setString(5, dto.getDuan_ma());
		stmt.setString(6, dto.getPhongban_ma());
		stmt.setString(7, dto.getKhuvuc_ma());
		stmt.setString(8, dto.getDungluong());
		stmt.setString(9, dto.getSoluong());
		stmt.setDate(10, DateUtils.convertToSQLDate(dto.getDateimport()) );
		stmt.execute();
		stmt.close();
		connection.close();
	}
	
	public void clear() {
		this.jdbcTemplate.execute("truncate table TUYENKENH_IMPORT drop storage");
	}
	
	
}