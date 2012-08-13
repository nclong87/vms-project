package vms.db.dao;


import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.List;

import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.core.RowMapper;

import vms.db.dto.PhongBan;

public class PhongBanDao {
	private JdbcTemplate jdbcTemplate;
	public PhongBanDao(DaoFactory daoFactory) {
		this.jdbcTemplate = daoFactory.getJdbcTemplate();
	}

	@SuppressWarnings("unchecked")
	public List<PhongBan> getAll() {
		return this.jdbcTemplate.query(
			    "select * from phongban where deleted = 0",
			    new RowMapper() {
			        public Object mapRow(ResultSet rs, int rowNum) throws SQLException {
			        	PhongBan phongBan = new PhongBan();
			        	phongBan.setId(rs.getLong("ID"));
			        	phongBan.setTenphongban(rs.getString("TENPHONGBAN"));
			        	phongBan.setDeleted(rs.getBoolean("DELETED"));
			            return phongBan;
			        }
			    });
	}
	
}