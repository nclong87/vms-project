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
import vms.db.dto.PhuLucDTO;
import vms.utils.DateUtils;
import vms.utils.VMSUtil;

public class PhuLucDAO {
	private JdbcTemplate jdbcTemplate;
	private DataSource jdbcDatasource;
	public PhuLucDAO(DaoFactory daoFactory) {
		this.jdbcTemplate = daoFactory.getJdbcTemplate();
		this.jdbcDatasource = daoFactory.getJdbcDataSource();
	}
	
	private static final String SQL_FIND_PHULUC = "{ ? = call FIND_PHULUC(?,?,?,?,?,?,?) }";
	public List<Map<String,Object>> search(int iDisplayStart,int iDisplayLength,Map<String, String> conditions) throws SQLException {
		Connection connection = jdbcDatasource.getConnection();
		CallableStatement stmt = connection.prepareCall(SQL_FIND_PHULUC);
		stmt.registerOutParameter(1, OracleTypes.CURSOR);
		stmt.setInt(2, iDisplayStart);
		stmt.setInt(3, iDisplayLength);
		stmt.setString(4, conditions.get("tenhopdong"));
		stmt.setString(5, conditions.get("tenphuluc"));
		stmt.setString(6, conditions.get("loaiphuluc"));
		stmt.setString(7, conditions.get("ngayky"));
		stmt.setString(8, conditions.get("ngayhieuluc"));
		stmt.execute();
		ResultSet rs = (ResultSet) stmt.getObject(1);
		List<Map<String,Object>> result = new ArrayList<Map<String,Object>>();
		int i = 1;
		while(rs.next()) {
			Map<String,Object> map = VMSUtil.resultSetToMap(rs);
			map.put("stt", i);
			map.put("ngayky", DateUtils.formatDate(rs.getDate("NGAYKY"), DateUtils.SDF_DDMMYYYY));
			map.put("ngayhieuluc", DateUtils.formatDate(rs.getDate("NGAYHIEULUC"), DateUtils.SDF_DDMMYYYY));
			map.put("ngayhethieuluc", DateUtils.formatDate(rs.getDate("NGAYHETHIEULUC"), DateUtils.SDF_DDMMYYYY));
			result.add(map);
			i++;
		}
		stmt.close();
		connection.close();
		return result;
	}
	
	public PhuLucDTO findById(String id) {
		return (PhuLucDTO) this.jdbcTemplate.queryForObject("select * from PHULUC where id = ? and DELETED = 0" ,new Object[] {id}, new RowMapper() {
			@Override
			public Object mapRow(ResultSet rs, int arg1) throws SQLException {
				return PhuLucDTO.mapObject(rs);
			}
		});
	}
	
	private static final String SQL_SAVE_PHULUC = "{ ? = call SAVE_PHULUC(?,?,?,?,?,?,?,?,?,?,?,?) }";
	public String save(PhuLucDTO dto) throws Exception {
		Connection connection = jdbcDatasource.getConnection();
		CallableStatement stmt = connection.prepareCall(SQL_SAVE_PHULUC);
		stmt.registerOutParameter(1, OracleTypes.VARCHAR);
		stmt.setString(2, dto.getId());
		stmt.setString(3, dto.getChitietphuluc_id());
		stmt.setString(4, dto.getHopdong_id());
		stmt.setString(5, dto.getTenphuluc());
		stmt.setString(6, String.valueOf(dto.getLoaiphuluc()));
		stmt.setString(7, dto.getNgayky());
		stmt.setString(8, dto.getNgayhieuluc());
		stmt.setString(9, dto.getUsercreate());
		stmt.setString(10, dto.getTimecreate());
		stmt.setString(11, dto.getFilename());
		stmt.setString(12, dto.getFilepath());
		stmt.setString(13, dto.getFilesize());
		stmt.execute();
		return stmt.getString(1);
	}
	
	public void deleteByIds(String[] ids) {
		String str = StringUtils.join(ids, ",");
		this.jdbcTemplate.update("update PHULUC set DELETED = 1 where ID in ("+str+")");
	}
	
	private static final String SQL_DETAIL_PHULUC = "SELECT t.*,t0.LOAIHOPDONG,t0.DOITAC_ID,t2.TENDOITAC,t1.CUOCDAUNOI,t1.GIATRITRUOCTHUE,t1.GIATRISAUTHUE,t1.SOLUONGKENH FROM PHULUC t "+
		"left join HOPDONG t0 on t.HOPDONG_ID = t0.ID " +
		"left join CHITIETPHULUC t1 on t.CHITIETPHULUC_ID = t1.ID " +
		"left join DOITAC t2 on t0.DOITAC_ID = t2.ID  WHERE where t.ID=?";
	@SuppressWarnings("unchecked")
	public Map<String,Object> getDetail(String id) {
		List<Map<String,Object>> list =  this.jdbcTemplate.query(SQL_DETAIL_PHULUC ,new Object[] {id}, new RowMapper() {
			@Override
			public Object mapRow(ResultSet rs, int arg1) throws SQLException {
				Map<String,Object> map = VMSUtil.resultSetToMap(rs);
				map.put("ngayky", DateUtils.formatDate(rs.getDate("NGAYKY"), DateUtils.SDF_DDMMYYYY));
				map.put("ngayhieuluc", DateUtils.formatDate(rs.getDate("NGAYHIEULUC"), DateUtils.SDF_DDMMYYYY));
				map.put("ngayhethieuluc", DateUtils.formatDate(rs.getDate("NGAYHETHIEULUC"), DateUtils.SDF_DDMMYYYY));
				return map;
			}
		});
		if(list.isEmpty()) return null;
		return list.get(0);
	}
}