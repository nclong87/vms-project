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

import org.apache.commons.lang3.StringUtils;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.core.RowMapper;

import vms.db.dto.TramDTO;
import vms.utils.StringUtil;
import vms.utils.VMSUtil;

public class TramDAO {
	private JdbcTemplate jdbcTemplate;
	private DataSource jdbcDatasource;
	public TramDAO(DaoFactory daoFactory) {
		this.jdbcTemplate = daoFactory.getJdbcTemplate();
		this.jdbcDatasource = daoFactory.getJdbcDataSource();
	}
	
	private static final String SQL_FN_FIND_TRAM = "{ ? = call FIND_TRAM(?,?,?,?) }";
	public List<Map<String,Object>> search(int iDisplayStart,int iDisplayLength,Map<String, String> conditions) throws SQLException {
		Connection connection = jdbcDatasource.getConnection();
		CallableStatement stmt = connection.prepareCall(SQL_FN_FIND_TRAM);
		stmt.registerOutParameter(1, OracleTypes.CURSOR);
		stmt.setInt(2, iDisplayStart);
		stmt.setInt(3, iDisplayLength);
		stmt.setString(4, conditions.get("matram"));
		stmt.setString(5, conditions.get("diachi"));
		stmt.execute();
		ResultSet rs = (ResultSet) stmt.getObject(1);
		List<Map<String,Object>> result = new ArrayList<Map<String,Object>>();
		int i = 1;
		while(rs.next()) {
			Map<String,Object> map = VMSUtil.resultSetToMap(rs);
			map.put("stt", i);
			result.add(map);
			i++;
		}
		stmt.close();
		connection.close();
		return result;
	}
	
	public TramDTO findById(String id) {
		return (TramDTO) this.jdbcTemplate.queryForObject("select * from TRAM where id = ? and DELETED = 0" ,new Object[] {id}, new RowMapper() {
			@Override
			public Object mapRow(ResultSet rs, int arg1) throws SQLException {
				return TramDTO.mapObject(rs);
			}
		});
	}
	
	@SuppressWarnings("unchecked")
	public TramDTO findByKey(String matram) {
		System.out.println("matram = "+matram);
		if(StringUtil.isEmpty(matram))
			return null;
		List<TramDTO> list =  this.jdbcTemplate.query("select * from TRAM where MATRAM = ? and DELETED = 0" ,new Object[] {matram}, new RowMapper() {
			@Override
			public Object mapRow(ResultSet rs, int arg1) throws SQLException {
				return TramDTO.mapObject(rs);
			}
		});
		if(list.isEmpty()) return null;
		return list.get(0);
	}
	
	private static final String SQL_SAVE_TRAM = "{ ? = call SAVE_TRAM(?,?,?) }";
	public String save(TramDTO dto) throws Exception {
		Connection connection = jdbcTemplate.getDataSource().getConnection();
		CallableStatement stmt = connection.prepareCall(SQL_SAVE_TRAM);
		stmt.registerOutParameter(1, OracleTypes.VARCHAR);
		stmt.setString(2, dto.getId());
		stmt.setString(3, dto.getMatram());
		stmt.setString(4, dto.getDiachi());
		stmt.execute();
		String id = stmt.getString(1);
		stmt.close();
		connection.close();
		return id;
	}
	
	public void deleteByIds(String[] ids) {
		String str = StringUtils.join(ids, ",");
		this.jdbcTemplate.update("update TRAM set DELETED = 1 where ID in ("+str+")");
	}
	
}