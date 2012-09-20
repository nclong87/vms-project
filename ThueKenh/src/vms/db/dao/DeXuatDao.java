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

import vms.db.dto.DeXuatDTO;
import vms.utils.DateUtils;
import vms.utils.VMSUtil;
import vms.web.models.FIND_DEXUAT;

public class DeXuatDao {
	private JdbcTemplate jdbcTemplate;
	private DataSource jdbcDatasource;
	public DeXuatDao(DaoFactory daoFactory) {
		this.jdbcTemplate = daoFactory.getJdbcTemplate();
		this.jdbcDatasource = daoFactory.getJdbcDataSource();
	}
	
	private static final String SQL_FIND_DEXUAT = "{ ? = call FIND_DEXUAT(?,?,?,?,?,?,?) }";
	public List<FIND_DEXUAT> search(int iDisplayStart,int iDisplayLength,Map<String, String> conditions) throws SQLException {
		Connection connection = jdbcDatasource.getConnection();
		CallableStatement stmt = connection.prepareCall(SQL_FIND_DEXUAT);
		stmt.registerOutParameter(1, OracleTypes.CURSOR);
		stmt.setInt(2, iDisplayStart);
		stmt.setInt(3, iDisplayLength);
		stmt.setString(4, conditions.get("doitac_id"));
		stmt.setString(5, conditions.get("tenvanban"));
		stmt.setString(6, conditions.get("ngaygui"));
		stmt.setString(7, conditions.get("ngaydenghibangiao"));
		stmt.setString(8, conditions.get("trangthai"));
		stmt.execute();
		ResultSet rs = (ResultSet) stmt.getObject(1);
		List<FIND_DEXUAT> result = new ArrayList<FIND_DEXUAT>();
		while(rs.next()) {
			result.add(FIND_DEXUAT.mapObject(rs));
		}
		stmt.close();
		connection.close();
		return result;
	}
	
	public DeXuatDTO findById(String id) {
		return (DeXuatDTO) this.jdbcTemplate.queryForObject("select * from DEXUAT where id = ? and DELETED = 0" ,new Object[] {id}, new RowMapper() {
			@Override
			public Object mapRow(ResultSet rs, int arg1) throws SQLException {
				return DeXuatDTO.mapObject(rs);
			}
		});
	}
	
	private static final String SQL_SAVE_DEXUAT = "{ ? = call SAVE_DEXUAT(?,?,?,?,?,?,?,?,?,?,?,?) }";
	public String save(DeXuatDTO dto) throws Exception {
		Connection connection = jdbcTemplate.getDataSource().getConnection();
		CallableStatement stmt = connection.prepareCall(SQL_SAVE_DEXUAT);
		stmt.registerOutParameter(1, OracleTypes.VARCHAR);
		stmt.setString(2, dto.getId());
		stmt.setString(3, dto.getDoitac_id());
		stmt.setString(4, dto.getFilename());
		stmt.setString(5, dto.getTenvanban());
		stmt.setString(6, dto.getNgaygui());
		stmt.setString(7, dto.getNgaydenghibangiao());
		stmt.setString(8, dto.getThongtinthem());
		stmt.setString(9, dto.getUsercreate());
		stmt.setString(10, dto.getTimecreate());
		stmt.setString(11, dto.getTrangthai().toString());
		stmt.setString(12, dto.getFilepath());
		stmt.setString(13, String.valueOf(dto.getFilesize()));
		stmt.execute();
		return stmt.getString(1);
	}
	
	public void deleteByIds(String[] ids) {
		String str = StringUtils.join(ids, ",");
		this.jdbcTemplate.update("update DEXUAT set DELETED = 1 where ID in ("+str+")");
	}
	
	private static final String SQL_DETAIL_DEXUAT = "select t.*,t0.TENDOITAC from DEXUAT t left join DOITAC t0 on t.DOITAC_ID = t0.ID where t.ID=?";
	@SuppressWarnings("unchecked")
	public Map<String,Object> getDetail(String id) {
		List<Map<String,Object>> list =  this.jdbcTemplate.query(SQL_DETAIL_DEXUAT ,new Object[] {id}, new RowMapper() {
			@Override
			public Object mapRow(ResultSet rs, int arg1) throws SQLException {
				Map<String,Object> map = VMSUtil.resultSetToMap(rs);
				map.put("ngaygui",DateUtils.formatDate(rs.getDate("NGAYGUI"), DateUtils.SDF_DDMMYYYY));
				map.put("ngaydenghibangiao",DateUtils.formatDate(rs.getDate("NGAYDENGHIBANGIAO"), DateUtils.SDF_DDMMYYYY));
				return map;
			}
		});
		if(list.isEmpty()) return null;
		return list.get(0);
	}
}