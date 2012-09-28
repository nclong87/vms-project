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
	
	
	@SuppressWarnings("unchecked")
	public Account checkLogin(String username, String password) {
		// FIXME checkLogin
		//Connection connection = jdbcTemplate.getDataSource().getConnection();
		List<Account> list = this.jdbcTemplate.query("select * from ACCOUNTS where active = 1 and username = ? and password = ?", new Object[] {username,password}, new RowMapper() {
			@Override
			public Object mapRow(ResultSet rs, int arg1) throws SQLException {
				return Account.mapObject(rs);
			}
		});
		if(list.isEmpty()) return null;
		return list.get(0);
	}
	
	@SuppressWarnings("unchecked")
	public Account findByUsername(String username) {
		List<Account> list = this.jdbcTemplate.query("select * from ACCOUNTS where active = 1 and username = ?", new Object[] {username}, new RowMapper() {
			@Override
			public Object mapRow(ResultSet rs, int arg1) throws SQLException {
				return Account.mapObject(rs);
			}
		});
		if(list.isEmpty()) return null;
		return list.get(0);
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
	public String getMenu(Account account) {
		System.out.println(account.getId()+"-"+account.getIdgroup());
		Clob clob = (Clob) this.jdbcTemplate.queryForObject(GETLISTMENU,new Object[] {account.getId(),account.getIdgroup()}, Clob.class);
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
	private static final String SAVE_ACCOUNT = "{ ? = call SAVE_ACCOUNT(?,?,?,?,?,?,?,?) }";
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
		stmt.setString(9, String.valueOf(account.getMainmenu()));
		stmt.execute();
		return stmt.getLong(1);
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
		Connection connection = this.jdbcDatasource.getConnection();
		System.out.println("***BEGIN saveAccountMenus***");
		ArrayDescriptor descriptor = ArrayDescriptor.createDescriptor( "TABLE_VARCHAR", connection );
		ARRAY array =new ARRAY( descriptor, connection, menu_id );
		CallableStatement stmt = connection.prepareCall(PROC_SAVE_ACCOUNTMENU);
		stmt.setArray(1, array);
		stmt.setString(2, account_id);
		stmt.execute();
		stmt.close();
		connection.close();
	}
}