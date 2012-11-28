package vms.db.dao;


import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;
import java.util.Set;

import javax.sql.DataSource;
import oracle.jdbc.OracleTypes;

import org.apache.commons.lang3.StringUtils;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.core.RowMapper;

import vms.db.dto.BienBanVanHanhKenhDTO;
import vms.db.dto.HopDongDTO;
import vms.utils.DateUtils;
import vms.utils.StringUtil;
import vms.utils.VMSUtil;

public class HopDongDAO {
	private JdbcTemplate jdbcTemplate;
	private DataSource jdbcDatasource;
	public HopDongDAO(DaoFactory daoFactory) {
		this.jdbcTemplate = daoFactory.getJdbcTemplate();
		this.jdbcDatasource = daoFactory.getJdbcDataSource();
	}
	
	private static final String SQL_FIND_HOPDONG = "{ ? = call FIND_HOPDONG(?,?,?,?,?,?,?,?,?) }";
	public List<Map<String,Object>> search(int iDisplayStart,int iDisplayLength,Map<String, String> conditions) throws SQLException {
		Connection connection = jdbcDatasource.getConnection();
		CallableStatement stmt = connection.prepareCall(SQL_FIND_HOPDONG);
		stmt.registerOutParameter(1, OracleTypes.CURSOR);
		stmt.setInt(2, iDisplayStart);
		stmt.setInt(3, iDisplayLength);
		stmt.setString(4, conditions.get("doitac_id"));
		stmt.setString(5, conditions.get("sohopdong"));
		stmt.setString(6, conditions.get("loaihopdong"));
		String ngaykytu="";
		if(conditions.get("ngaykytu")!=null)
			ngaykytu=DateUtils.parseStringDateSQL(conditions.get("ngaykytu"), "dd/MM/yyyy");
		stmt.setString(7, ngaykytu);
		String ngaykyden="";
		if(conditions.get("ngaykyden")!=null)
			ngaykyden=DateUtils.parseStringDateSQL(conditions.get("ngaykyden"), "dd/MM/yyyy");
		stmt.setString(8, ngaykyden);
		String ngayhethantu="";
		if(conditions.get("ngayhethantu")!=null)
			ngayhethantu=DateUtils.parseStringDateSQL(conditions.get("ngayhethantu"), "dd/MM/yyyy");
		stmt.setString(9, ngayhethantu);
		String ngayhethanden="";
		if(conditions.get("ngayhethanden")!=null)
			ngayhethanden=DateUtils.parseStringDateSQL(conditions.get("ngayhethanden"), "dd/MM/yyyy");
		stmt.setString(10, ngayhethanden);
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
	
	@SuppressWarnings("unchecked")
	public HopDongDTO findBySohopdong(String sohopdong) {
		if(StringUtil.isEmpty(sohopdong))
			return null;
		List<HopDongDTO> list =  this.jdbcTemplate.query("SELECT * FROM HOPDONG WHERE SOHOPDONG = ? AND DELETED = 0" ,new Object[] {sohopdong}, new RowMapper() {
			@Override
			public Object mapRow(ResultSet rs, int arg1) throws SQLException {
				return HopDongDTO.mapObject(rs);
			}
		});
		if(list.isEmpty()) return null;
		return list.get(0);
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
		String rs = stmt.getString(1);
		stmt.close();
		connection.close();
		return rs;
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
	
	@SuppressWarnings("unchecked")
	public List<Map<String,Object>> getAll() {
		return  this.jdbcTemplate.query("select * from HOPDONG where DELETED = 0", new RowMapper() {
			@Override
			public Object mapRow(ResultSet rs, int arg1) throws SQLException {
				Map<String,Object> map = VMSUtil.resultSetToMap(rs);
				map.put("ngayky", DateUtils.formatDate(rs.getDate("NGAYKY"), DateUtils.SDF_DDMMYYYY));
				map.put("ngayhethan", DateUtils.formatDate(rs.getDate("NGAYHETHAN"), DateUtils.SDF_DDMMYYYY));
				return map;
			}
		});
	}
	
	@SuppressWarnings("unchecked")
	public List<Map<String,Object>> findByDoitac(String doitac_id) {
		return  this.jdbcTemplate.query("select * from HOPDONG where DELETED = 0 and DOITAC_ID = ?", new Object[] {doitac_id}, new RowMapper() {
			@Override
			public Object mapRow(ResultSet rs, int arg1) throws SQLException {
				Map<String,Object> map = VMSUtil.resultSetToMap(rs);
				map.put("ngayky", DateUtils.formatDate(rs.getDate("NGAYKY"), DateUtils.SDF_DDMMYYYY));
				map.put("ngayhethan", DateUtils.formatDate(rs.getDate("NGAYHETHAN"), DateUtils.SDF_DDMMYYYY));
				return map;
			}
		});
	}
	
	@SuppressWarnings("unchecked")
	public Map<String,Map<String,Object>> findAllHopDongByDoitac() {
		List<Map<String,Object>> list = this.jdbcTemplate.query("select t.*,t1.tendoitac from HOPDONG t left join DOITAC t1 on t.doitac_id = t1.id where t.DELETED = 0", new RowMapper() {
			@Override
			public Object mapRow(ResultSet rs, int arg1) throws SQLException {
				Map<String,Object> map = VMSUtil.resultSetToMap(rs);
				map.put("ngayky", DateUtils.formatDate(rs.getDate("NGAYKY"), DateUtils.SDF_DDMMYYYY));
				map.put("ngayhethan", DateUtils.formatDate(rs.getDate("NGAYHETHAN"), DateUtils.SDF_DDMMYYYY));
				return map;
			}
		});
		Map<String,Map<String,Object>> result = new LinkedHashMap<String, Map<String,Object>>();
		for(int i =0 ;i<list.size();i++) {
			Map<String,Object> map = list.get(i);
			String doitac_id = (String) map.get("doitac_id");
			if(result.containsKey(doitac_id)) {
				Map<String,Object> doitac = result.get(doitac_id);
				List<Map<String,Object>> listHopDong = (List<Map<String, Object>>) doitac.get("hopdong");
				listHopDong.add(map);
				doitac.put("hopdong",listHopDong);
				result.put(doitac_id, doitac);
			} else {
				Map<String,Object> doitac = new LinkedHashMap<String, Object>();
				doitac.put("id", doitac_id);
				doitac.put("tendoitac", map.get("tendoitac"));
				List<Map<String,Object>> listHopDong = new ArrayList<Map<String,Object>>();
				listHopDong.add(map);
				doitac.put("hopdong",listHopDong);
				result.put(doitac_id, doitac);
			}
		}
		return result;
	}
}