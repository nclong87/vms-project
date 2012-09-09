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
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.core.RowMapper;

import vms.db.dto.Account;
import vms.db.dto.TuyenKenh;
import vms.web.models.FN_FIND_TUYENKENH;

public class TuyenkenhDao {
	private JdbcTemplate jdbcTemplate;
	private DataSource jdbcDatasource;
	public TuyenkenhDao(DaoFactory daoFactory) {
		this.jdbcTemplate = daoFactory.getJdbcTemplate();
		this.jdbcDatasource = daoFactory.getJdbcDataSource();
	}
	
	private static final String SQL_FN_FIND_TUYENKENH = "{ ? = call FN_FIND_TUYENKENH(?,?,?,?,?,?,?,?,?,?,?,?) }";
	public List<FN_FIND_TUYENKENH> findTuyenkenh(int iDisplayStart,int iDisplayLength,Map<String, String> conditions) throws SQLException {
		Connection connection = jdbcDatasource.getConnection();
		CallableStatement stmt = connection.prepareCall(SQL_FN_FIND_TUYENKENH);
		stmt.registerOutParameter(1, OracleTypes.CURSOR);
		stmt.setInt(2, iDisplayStart);
		stmt.setInt(3, iDisplayLength);
		stmt.setString(4, conditions.get("makenh"));
		stmt.setString(5, conditions.get("loaigiaotiep"));
		stmt.setString(6, conditions.get("madiemdau"));
		stmt.setString(7, conditions.get("madiemcuoi"));
		stmt.setString(8, conditions.get("duan"));
		stmt.setString(9, conditions.get("khuvuc"));
		stmt.setString(10, conditions.get("phongban"));
		stmt.setString(11, conditions.get("ngaydenghibangiao"));
		stmt.setString(12, conditions.get("ngayhenbangiao"));
		stmt.setString(13, conditions.get("trangthai"));
		stmt.execute();
		ResultSet rs = (ResultSet) stmt.getObject(1);
		List<FN_FIND_TUYENKENH> result = new ArrayList<FN_FIND_TUYENKENH>();
		while(rs.next()) {
			result.add(FN_FIND_TUYENKENH.mapObject(rs));
		}
		stmt.close();
		connection.close();
		return result;
	}
	
	public TuyenKenh findById(String id) {
		return (TuyenKenh) this.jdbcTemplate.queryForObject("select * from TUYENKENH where id = ? and DELETED = 0" ,new Object[] {id}, new RowMapper() {
			@Override
			public Object mapRow(ResultSet rs, int arg1) throws SQLException {
				return TuyenKenh.mapObject(rs);
			}
		});
	}
	
	private static final String SQL_SAVE_TUYENKENH = "{ ? = call SAVE_TUYENKENH(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?) }";
	public String save(TuyenKenh dto) throws Exception {
		Connection connection = jdbcTemplate.getDataSource().getConnection();
		CallableStatement stmt = connection.prepareCall(SQL_SAVE_TUYENKENH);
		stmt.registerOutParameter(1, OracleTypes.VARCHAR);
		stmt.setString(2, dto.getId());
		stmt.setString(3, dto.getDiemdau_id());
		stmt.setString(4, dto.getDiemcuoi_id());
		stmt.setString(5, dto.getGiaotiep_id());
		stmt.setString(6, dto.getDuan_id());
		stmt.setString(7, dto.getPhongban_id());
		stmt.setString(8, dto.getKhuvuc_id());
		stmt.setString(9, dto.getDungluong().toString());
		stmt.setString(10, dto.getSoluong().toString());
		stmt.setString(11, dto.getNgaydenghibangiao());
		stmt.setString(12, dto.getNgayhenbangiao());
		stmt.setString(13, dto.getThongtinlienhe());
		stmt.setString(14, dto.getTrangthai().toString());
		stmt.setString(15, dto.getUsercreate());
		stmt.setString(16, dto.getTimecreate());
		stmt.setString(17, dto.getDeleted().toString());
		stmt.execute();
		return stmt.getString(1);
	}
}