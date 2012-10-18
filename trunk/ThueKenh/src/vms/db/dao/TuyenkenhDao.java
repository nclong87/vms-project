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

import vms.db.dto.TuyenKenh;
import vms.utils.StringUtil;
import vms.utils.VMSUtil;

public class TuyenkenhDao {
	private JdbcTemplate jdbcTemplate;
	private DataSource jdbcDatasource;
	public TuyenkenhDao(DaoFactory daoFactory) {
		this.jdbcTemplate = daoFactory.getJdbcTemplate();
		this.jdbcDatasource = daoFactory.getJdbcDataSource();
	}
	
	private static final String SQL_FN_FIND_TUYENKENH = "{ ? = call FN_FIND_TUYENKENH(?,?,?,?,?,?,?,?,?,?,?,?) }";
	public List<Map<String,Object>> findTuyenkenh(int iDisplayStart,int iDisplayLength,Map<String, String> conditions) throws SQLException {
		Connection connection = jdbcDatasource.getConnection();
		CallableStatement stmt = connection.prepareCall(SQL_FN_FIND_TUYENKENH);
		stmt.registerOutParameter(1, OracleTypes.CURSOR);
		stmt.setInt(2, iDisplayStart);
		stmt.setInt(3, iDisplayLength);
		stmt.setString(4, conditions.get("makenh"));
		stmt.setString(5, conditions.get("loaigiaotiep"));
		stmt.setString(6, conditions.get("madiemdau"));
		stmt.setString(7, conditions.get("madiemcuoi"));
		stmt.setString(8, conditions.get("duan"));
		stmt.setString(9, conditions.get("doitac"));
		stmt.setString(10, conditions.get("phongban"));
		stmt.setString(11, conditions.get("ngaydenghibangiao"));
		stmt.setString(12, conditions.get("ngayhenbangiao"));
		stmt.setString(13, conditions.get("trangthai"));
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
	
	public TuyenKenh findById(String id) {
		return (TuyenKenh) this.jdbcTemplate.queryForObject("select * from TUYENKENH where id = ? and DELETED = 0" ,new Object[] {id}, new RowMapper() {
			@Override
			public Object mapRow(ResultSet rs, int arg1) throws SQLException {
				return TuyenKenh.mapObject(rs);
			}
		});
	}
	
	@SuppressWarnings("unchecked")
	public TuyenKenh findByKey(String madiemdau,String madiemcuoi,String giaotiep_id,int dungluong) {
		/*if(StringUtil.isEmpty(madiemdau) || StringUtil.isEmpty(madiemcuoi) || StringUtil.isEmpty(giaotiep_id))
			return null;*/
		List<TuyenKenh> list =  this.jdbcTemplate.query("select * from TUYENKENH where DELETED = 0 and MADIEMDAU = ? and MADIEMCUOI =? and GIAOTIEP_ID =? and DUNGLUONG = ?" ,new Object[] {madiemdau,madiemcuoi,giaotiep_id,dungluong}, new RowMapper() {
			@Override
			public Object mapRow(ResultSet rs, int arg1) throws SQLException {
				return TuyenKenh.mapObject(rs);
			}
		});
		if(list.isEmpty()) return null;
		return list.get(0);
	}
	
	@SuppressWarnings("unchecked")
	public TuyenKenh findByKey2(String madiemdau,String madiemcuoi,String magiaotiep,int dungluong) {
		List<TuyenKenh> list =  this.jdbcTemplate.query("select t0.* from TUYENKENH t0 left join LOAIGIAOTIEP t1 on t0.GIAOTIEP_ID=t1.ID where t0.DELETED = 0 and MADIEMDAU = ? and MADIEMCUOI =? and t1.MA =? and DUNGLUONG = ?" ,new Object[] {madiemdau,madiemcuoi,magiaotiep,dungluong}, new RowMapper() {
			@Override
			public Object mapRow(ResultSet rs, int arg1) throws SQLException {
				return TuyenKenh.mapObject(rs);
			}
		});
		if(list.isEmpty()) return null;
		return list.get(0);
	}
	
	private static final String SQL_SAVE_TUYENKENH = "{ ? = call SAVE_TUYENKENH(?,?,?,?,?,?,?,?,?,?,?,?,?) }";
	public String save(TuyenKenh dto) throws Exception {
		Connection connection = jdbcTemplate.getDataSource().getConnection();
		CallableStatement stmt = connection.prepareCall(SQL_SAVE_TUYENKENH);
		stmt.registerOutParameter(1, OracleTypes.VARCHAR);
		stmt.setString(2, dto.getId());
		stmt.setString(3, dto.getMadiemdau());
		stmt.setString(4, dto.getMadiemcuoi());
		stmt.setString(5, dto.getGiaotiep_id());
		stmt.setString(6, dto.getDuan_id());
		stmt.setString(7, dto.getPhongban_id());
		stmt.setString(8, dto.getDoitac_id());
		stmt.setString(9, dto.getDungluong().toString());
		stmt.setString(10, dto.getSoluong().toString());
		//stmt.setString(11, dto.getNgaydenghibangiao());
		//stmt.setString(12, dto.getNgayhenbangiao());
		//stmt.setString(13, dto.getThongtinlienhe());
		stmt.setString(11, String.valueOf(dto.getTrangthai()));
		stmt.setString(12, dto.getUsercreate());
		stmt.setString(13, dto.getTimecreate());
		stmt.setString(14, String.valueOf(dto.getDeleted()));
		stmt.execute();
		String id = stmt.getString(1);
		stmt.close();
		connection.close();
		return id;
	}
	
	public void deleteByIds(String[] ids) {
		for(int i=0;i<ids.length;i++) {
			ids[i] = "'"+ids[i]+"'";
		}
		String str = StringUtils.join(ids, ",");
		long time = System.currentTimeMillis();
		String query = "update TUYENKENH set DELETED = "+time+" where ID in ("+str+")";
		this.jdbcTemplate.update(query);
	}
	
	private static final String SQL_DETAIL_TUYENKENH = "select t.*,TENDUAN,TENDOITAC,LOAIGIAOTIEP,TENPHONGBAN from TUYENKENH t left join LOAIGIAOTIEP t0 on t.GIAOTIEP_ID = t0.ID left join DUAN t1 on t.DUAN_ID = t1.ID left join PHONGBAN t2 on t.PHONGBAN_ID = t2.ID left join DOITAC t3 on t.DOITAC_ID = t3.ID where t.ID = ?";
	@SuppressWarnings("unchecked")
	public Map<String,Object> getDetail(String id) {
		List<Map<String,Object>> list =  this.jdbcTemplate.query(SQL_DETAIL_TUYENKENH ,new Object[] {id}, new RowMapper() {
			@Override
			public Object mapRow(ResultSet rs, int arg1) throws SQLException {
				return VMSUtil.resultSetToMap(rs);
			}
		});
		if(list.isEmpty()) return null;
		return list.get(0);
	}
}