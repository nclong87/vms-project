package vms.db.dao;

import java.sql.CallableStatement;
import java.sql.Connection;
import javax.sql.DataSource;
import oracle.jdbc.OracleTypes;

import org.springframework.jdbc.core.JdbcTemplate;

import vms.db.dto.VanHanhSuCoKenhDTO;

public class VanHanhSuCoKenhDAO {
	private JdbcTemplate jdbcTemplate;
	@SuppressWarnings("unused")
	private DataSource jdbcDatasource;

	public VanHanhSuCoKenhDAO(DaoFactory daoFactory) {
		this.jdbcTemplate = daoFactory.getJdbcTemplate();
		this.jdbcDatasource = daoFactory.getJdbcDataSource();
	}

	private static final String SQL_SAVE_VANHANH_SUCOKENH = "{ ? = call SAVE_VANHANH_SUCOKENH(?,?) }";

	public String save(VanHanhSuCoKenhDTO dto) throws Exception {
		System.out.println("begin call SQL_SAVE_VANHANH_SUCOKENH");
		Connection connection = jdbcTemplate.getDataSource().getConnection();
		CallableStatement stmt = connection
				.prepareCall(SQL_SAVE_VANHANH_SUCOKENH);
		stmt.registerOutParameter(1, OracleTypes.VARCHAR);
		stmt.setString(2, dto.getBienban_id());
		stmt.setString(3, dto.getSucokenh_id());
		stmt.execute();
		String rs = stmt.getString(1);
		stmt.close();
		connection.close();
		System.out.println("end call SQL_SAVE_VANHANH_SUCOKENH");
		return rs;
	}
	
	public void deleteByBienBanIds(String bienban_id) {
		this.jdbcTemplate.update("DELETE FROM VANHANH_SUCOKENH WHERE BIENBAN_ID="+bienban_id);
	}
}
