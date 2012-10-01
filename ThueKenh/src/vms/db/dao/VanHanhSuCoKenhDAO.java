package vms.db.dao;

import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;
import javax.sql.DataSource;
import oracle.jdbc.OracleTypes;

import org.apache.commons.lang3.StringUtils;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.core.RowMapper;

import vms.db.dto.BienBanVanHanhKenhDTO;
import vms.db.dto.SuCoDTO;
import vms.db.dto.VanHanhSuCoKenhDTO;
import vms.utils.DateUtils;
import vms.utils.VMSUtil;
import vms.web.models.FN_FIND_SUCO;

public class VanHanhSuCoKenhDAO {
	private JdbcTemplate jdbcTemplate;
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
		System.out.println("end call SQL_SAVE_VANHANH_SUCOKENH");
		return stmt.getString(1);
	}
	
	public void deleteByBienBanIds(String bienban_id) {
		this.jdbcTemplate.update("DELETE FROM VANHANH_SUCOKENH WHERE BIENBAN_ID="+bienban_id);
	}
}
