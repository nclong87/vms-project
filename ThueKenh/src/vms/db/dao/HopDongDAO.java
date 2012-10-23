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

import vms.db.dto.HopDongDTO;
import vms.utils.DateUtils;
import vms.utils.VMSUtil;

public class HopDongDAO {
	private JdbcTemplate jdbcTemplate;
	private DataSource jdbcDatasource;
	public HopDongDAO(DaoFactory daoFactory) {
		this.jdbcTemplate = daoFactory.getJdbcTemplate();
		this.jdbcDatasource = daoFactory.getJdbcDataSource();
	}
	
	private static final String SQL_FIND_HOPDONG = "{ ? = call FIND_HOPDONG(?,?,?,?,?,?,?) }";
	public List<Map<String,Object>> search(int iDisplayStart,int iDisplayLength,Map<String, String> conditions) throws SQLException {
		Connection connection = jdbcDatasource.getConnection();
		CallableStatement stmt = connection.prepareCall(SQL_FIND_HOPDONG);
		stmt.registerOutParameter(1, OracleTypes.CURSOR);
		stmt.setInt(2, iDisplayStart);
		stmt.setInt(3, iDisplayLength);
		stmt.setString(4, conditions.get("doitac_id"));
		stmt.setString(5, conditions.get("sohopdong"));
		stmt.setString(6, conditions.get("loaihopdong"));
		stmt.setString(7, conditions.get("ngayky"));
		stmt.setString(8, conditions.get("ngayhethan"));
		stmt.execute();
		ResultSet rs = (ResultSet) stmt.getObject(1);
		List<Map<String,Object>> result = new ArrayList<Map<String,Object>>();
		int i = 1;
		while(rs.next()) {
			Map<String,Object> map = VMSUtil.resultSetToMap(rs);
			map.put("stt", i);
			map.put("ngayky", DateUtils.formatDate(rs.getDate("NGAYKY"), DateUtils.SDF_DDMMYYYY));
			map.put("ngayhethan", DateUtils.formatDate(rs.getDate("NGAYHETHAN"), DateUtils.SDF_DDMMYYYY));
			result.add(map);
			i++;
		}
		stmt.close();
		connection.close();
		return result;
	}
	
	public HopDongDTO findById(String id) {
		return (HopDongDTO) this.jdbcTemplate.queryForObject("select * from HOPDONG where id = ? and DELETED = 0" ,new Object[] {id}, new RowMapper() {
			@Override
			public Object mapRow(ResultSet rs, int arg1) throws SQLException {
				return HopDongDTO.mapObject(rs);
			}
		});
	}
	
	private static final String SQL_SAVE_HOPDONG = "{ ? = call SAVE_HOPDONG(?,?,?,?,?,?,?,?,?) }";
	public String save(HopDongDTO dto) throws Exception {
		Connection connection = jdbcDatasource.getConnection();
		CallableStatement stmt = connection.prepareCall(SQL_SAVE_HOPDONG);
		stmt.registerOutParameter(1, OracleTypes.VARCHAR);
		stmt.setString(2, dto.getId());
		stmt.setString(3, dto.getDoitac_id());
		stmt.setString(4, dto.getSohopdong());
		stmt.setString(5, String.valueOf(dto.getLoaihopdong()));
		stmt.setString(6, dto.getNgayky());
		stmt.setString(7, dto.getNgayhethan());
		stmt.setString(8, dto.getUsercreate());
		stmt.setString(9, dto.getTimecreate());
		stmt.setString(10, dto.getHistory());
		stmt.execute();
		return stmt.getString(1);
	}
	
	public void deleteByIds(String[] ids) {
		String str = StringUtils.join(ids, ",");
		this.jdbcTemplate.update("update HOPDONG set DELETED = 1 where ID in ("+str+")");
	}
	
	private static final String SQL_DETAIL_HOPDONG = "select t.*,t0.TENDOITAC from HOPDONG t left join DOITAC t0 on t.DOITAC_ID = t0.ID where t.ID=?";
	@SuppressWarnings("unchecked")
	public Map<String,Object> getDetail(String id) {
		List<Map<String,Object>> list =  this.jdbcTemplate.query(SQL_DETAIL_HOPDONG ,new Object[] {id}, new RowMapper() {
			@Override
			public Object mapRow(ResultSet rs, int arg1) throws SQLException {
				Map<String,Object> map = VMSUtil.resultSetToMap(rs);
				map.put("ngayky", DateUtils.formatDate(rs.getDate("NGAYKY"), DateUtils.SDF_DDMMYYYY));
				map.put("ngayhethan", DateUtils.formatDate(rs.getDate("NGAYHETHAN"), DateUtils.SDF_DDMMYYYY));
				return map;
			}
		});
		if(list.isEmpty()) return null;
		return list.get(0);
	}
}