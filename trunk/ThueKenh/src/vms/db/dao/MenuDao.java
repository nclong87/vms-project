package vms.db.dao;


import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.List;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.core.RowMapper;
import vms.db.dto.Menu;
import vms.db.dto.Rootmenu;

public class MenuDao {
	private JdbcTemplate jdbcTemplate;
	public MenuDao(DaoFactory daoFactory) {
		this.jdbcTemplate = daoFactory.getJdbcTemplate();
	}
	
	
	@SuppressWarnings("unchecked")
	public List<Menu> getMenusByRoot(String idrootmenu) {
		return this.jdbcTemplate.query("select * from MENU where active = 1 and IDROOTMENU = ?", new Object[] {idrootmenu}, new RowMapper() {
			@Override
			public Object mapRow(ResultSet rs, int arg1) throws SQLException {
				return Menu.mapObject(rs);
			}
		});
	}
	
	@SuppressWarnings("unchecked")
	public List<Rootmenu> getRootmenu() {
		return this.jdbcTemplate.query("select * from ROOTMENU order by NAME asc", new RowMapper() {
			@Override
			public Object mapRow(ResultSet rs, int arg1) throws SQLException {
				return Rootmenu.mapObject(rs);
			}
		});
	}
}