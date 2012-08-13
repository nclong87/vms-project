package vms.db.dao;


import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.List;

import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.core.RowMapper;

import vms.db.dto.KhuVuc;

public class KhuVucDao {
	private JdbcTemplate jdbcTemplate;
	public KhuVucDao(DaoFactory daoFactory) {
		this.jdbcTemplate = daoFactory.getJdbcTemplate();
	}

	@SuppressWarnings("unchecked")
	public List<KhuVuc> getAll() {
		return this.jdbcTemplate.query(
			    "select * from khuvuc where deleted = 0",
			    new RowMapper() {
			        public Object mapRow(ResultSet rs, int rowNum) throws SQLException {
			        	KhuVuc dto = new KhuVuc();
			        	dto.setId(rs.getLong("ID"));
			        	dto.setTenkhuvuc(rs.getString("TENKHUVUC"));
			        	dto.setDeleted(rs.getBoolean("DELETED"));
			            return dto;
			        }
			    });
	}
	
}