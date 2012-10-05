package vms.db.dao;


import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.core.RowMapper;

import vms.db.dto.Menu;
import vms.db.dto.Rootmenu;
import vms.utils.VMSUtil;

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
	
	@SuppressWarnings("unchecked")
	public List<Menu> getAll() {
		return this.jdbcTemplate.query("select * from MENU where active = 1", new RowMapper() {
			@Override
			public Object mapRow(ResultSet rs, int arg1) throws SQLException {
				return Menu.mapObject(rs);
			}
		});
	}
	
	@SuppressWarnings("unchecked")
	public String getDefaultMenu(Map<String,Object> account) {
		List<Map<String,Object>> list = new ArrayList<Map<String,Object>>();
		if(account.get("mainmenu") != null ) {
			list = this.jdbcTemplate.query("select ACTION from MENU where ID = ?", new Object[] {account.get("mainmenu")}, new RowMapper() {
				@Override
				public Object mapRow(ResultSet rs, int arg1) throws SQLException {
					return VMSUtil.resultSetToMap(rs);
				}
			});
			
		} else if(account.get("idgroup") != null){
			list = this.jdbcTemplate.query("select ACTION from VMSGROUP t left join MENU t0 on t.MAINMENU = t0.ID where t.ID = ?", new Object[] {account.get("idgroup")}, new RowMapper() {
				@Override
				public Object mapRow(ResultSet rs, int arg1) throws SQLException {
					return VMSUtil.resultSetToMap(rs);
				}
			});
		}
		if(list.size()>0) {
			return String.valueOf(list.get(0).get("action"));
		}
		return null;
	}
}