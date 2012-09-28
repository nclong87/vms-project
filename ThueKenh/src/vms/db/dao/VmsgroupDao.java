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
import oracle.sql.ARRAY;
import oracle.sql.ArrayDescriptor;

import org.apache.commons.lang3.StringUtils;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.core.RowMapper;

import vms.db.dto.Menu;
import vms.db.dto.Vmsgroup;
import vms.utils.VMSUtil;

public class VmsgroupDao {
	private JdbcTemplate jdbcTemplate;
	private DataSource jdbcDatasource;
	public VmsgroupDao(DaoFactory daoFactory) {
		this.jdbcTemplate = daoFactory.getJdbcTemplate();
		this.jdbcDatasource = daoFactory.getJdbcDataSource();
	}
	
	@SuppressWarnings("unchecked")
	public List<Map<String,Object>> getAll() {
		return this.jdbcTemplate.query("select t.*,t0.NAMEMENU from VMSGROUP t left join MENU t0 on t.MAINMENU = t0.ID where t.active = 1 order by t.ID desc", new RowMapper() {
			@Override
			public Object mapRow(ResultSet rs, int arg1) throws SQLException {
				Map<String,Object> map = VMSUtil.resultSetToMap(rs);
				map.put("stt", arg1);
				return map;
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
	
	private static final String SAVE_VMSGROUP = "{ ? = call SAVE_VMSGROUP(?,?,?) }";
	public Long save(Vmsgroup vmsgroup) throws Exception {
		Connection connection = jdbcTemplate.getDataSource().getConnection();
		CallableStatement stmt = connection.prepareCall(SAVE_VMSGROUP);
		stmt.registerOutParameter(1, OracleTypes.INTEGER);
		stmt.setString(2, vmsgroup.getId());
		stmt.setString(3, vmsgroup.getNamegroup());
		stmt.setString(4, String.valueOf(vmsgroup.getMainmenu()));
		stmt.execute();
		Long rs = stmt.getLong(1);
		stmt.close();
		connection.close();
		return rs;
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