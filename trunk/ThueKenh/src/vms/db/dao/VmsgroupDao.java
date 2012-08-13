package vms.db.dao;


import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import javax.sql.DataSource;

import oracle.jdbc.OracleTypes;
import oracle.sql.ARRAY;
import oracle.sql.ArrayDescriptor;

import org.apache.commons.lang3.StringUtils;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.core.RowMapper;

import vms.db.dto.Menu;
import vms.db.dto.Vmsgroup;
import vms.web.models.AccountExt;

public class VmsgroupDao {
	private JdbcTemplate jdbcTemplate;
	private DataSource jdbcDatasource;
	public VmsgroupDao(DaoFactory daoFactory) {
		this.jdbcTemplate = daoFactory.getJdbcTemplate();
		this.jdbcDatasource = daoFactory.getJdbcDataSource();
	}
	
	@SuppressWarnings("unchecked")
	public List<Vmsgroup> getAll() {
		return this.jdbcTemplate.query("select * from VMSGROUP where active = 1 order by ID desc", new RowMapper() {
			@Override
			public Object mapRow(ResultSet rs, int arg1) throws SQLException {
				return Vmsgroup.mapObject(rs);
			}
		});
	}
	public Vmsgroup findById(String id) {
		return (Vmsgroup) this.jdbcTemplate.queryForObject("select * from VMSGROUP where id = ? " ,new Object[] {id}, new RowMapper() {
			@Override
			public Object mapRow(ResultSet rs, int arg1) throws SQLException {
				return Vmsgroup.mapObject(rs);
			}
		});
	}
	
	private static final String SAVE_VMSGROUP = "{ ? = call SAVE_VMSGROUP(?,?) }";
	public Long save(Vmsgroup vmsgroup) throws Exception {
		Connection connection = jdbcTemplate.getDataSource().getConnection();
		CallableStatement stmt = connection.prepareCall(SAVE_VMSGROUP);
		stmt.registerOutParameter(1, OracleTypes.INTEGER);
		stmt.setString(2, vmsgroup.getId());
		stmt.setString(3, vmsgroup.getNamegroup());
		stmt.execute();
		return stmt.getLong(1);
	}
	
	public void lock(String[] ids,String active) {
		String str = StringUtils.join(ids, ",");
		this.jdbcTemplate.update("update VMSGROUP set ACTIVE = ? where ID in ("+str+")",new Object[] {active});
	}
	
	private static final String PROC_SAVE_GROUPMENU = "{ call PROC_SAVE_GROUPMENU(?,?) }";
	public void saveGroupMenus(String[] menu_id,String group_id) throws Exception {
		Connection connection = this.jdbcDatasource.getConnection();
		System.out.println("***BEGIN saveGroupMenus***");
		ArrayDescriptor descriptor = ArrayDescriptor.createDescriptor( "TABLE_VARCHAR", connection );
		ARRAY array =new ARRAY( descriptor, connection, menu_id );
		CallableStatement stmt = connection.prepareCall(PROC_SAVE_GROUPMENU);
		stmt.setArray(1, array);
		stmt.setString(2, group_id);
		stmt.execute();
		stmt.close();
		connection.close();
	}
	
	private static final String GET_MENU_BY_GROUP = "{ ? = call GET_MENU_BY_GROUP(?) }";
	public List<Menu> getMenuOfGroup(String idgroup) throws Exception {
		Connection connection = jdbcTemplate.getDataSource().getConnection();
		CallableStatement stmt = connection.prepareCall(GET_MENU_BY_GROUP);
		stmt.registerOutParameter(1, OracleTypes.CURSOR);
		stmt.setString(2, idgroup);
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
}