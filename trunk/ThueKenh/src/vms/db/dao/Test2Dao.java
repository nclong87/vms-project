package vms.db.dao;



import java.sql.Clob;

import org.springframework.jdbc.core.JdbcTemplate;

import vms.db.dto.Account;
import vms.utils.StringUtil;

public class Test2Dao {
	
	private JdbcTemplate jdbcTemplate;
	public Test2Dao(DaoFactory daoFactory) {
		this.jdbcTemplate = daoFactory.getJdbcTemplate();
	}
	
	/*@SuppressWarnings("unchecked")
	public List<NhanvienDto> getAll() {
		return this.jdbcTemplate.query(
		    "select * from nhanvien",
		    new RowMapper() {
		        public Object mapRow(ResultSet rs, int rowNum) throws SQLException {
		            NhanvienDto actor = new NhanvienDto();
		            actor.setMsnhanvien(rs.getString("TENNHANVIEN"));
		            actor.setName(rs.getString("MSNHANVIEN"));
		            return actor;
		        }
		    });
	}*/
	
	private static final String GETLISTMENU = "SELECT GETLISTMENU(?,?) AS RS FROM DUAL";
	public String getMenu(Account account) {
		Clob clob = (Clob) this.jdbcTemplate.queryForObject(GETLISTMENU,new Object[] {account.getId(),""}, Clob.class);
		return StringUtil.clobToString(clob);
	}
}