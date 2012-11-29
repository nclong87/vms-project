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

import vms.db.dto.TuyenKenh;
import vms.db.dto.TuyenKenhDeXuatDTO;
import vms.utils.DateUtils;
import vms.utils.VMSUtil;

public class TuyenKenhDeXuatDAO {
	private JdbcTemplate jdbcTemplate;
	private DataSource jdbcDatasource;
	public TuyenKenhDeXuatDAO(DaoFactory daoFactory) {
		this.jdbcTemplate = daoFactory.getJdbcTemplate();
		this.jdbcDatasource = daoFactory.getJdbcDataSource();
	}
	
	private static final String SQL_FIND_TUYENKENHDEXUAT = "{ ? = call FIND_TUYENKENHDEXUAT(?,?,?,?,?,?,?,?,?,?,?,?,?,?) }";
	public List<Map<String,Object>> search(int iDisplayStart,int iDisplayLength,Map<String, String> conditions) throws SQLException {
		Connection connection = jdbcDatasource.getConnection();
		CallableStatement stmt = connection.prepareCall(SQL_FIND_TUYENKENHDEXUAT);
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
		stmt.setString(14, conditions.get("dexuat_id"));
		stmt.setString(15, conditions.get("bangiao_id"));
		stmt.execute();
		ResultSet rs = (ResultSet) stmt.getObject(1);
		List<Map<String,Object>> result = new ArrayList<Map<String,Object>>();
		int i = 1;
		while(rs.next()) {
			Map<String,Object> map = VMSUtil.resultSetToMap(rs);
			map.put("stt", i);
			map.put("ngayhenbangiao",DateUtils.formatDate(rs.getDate("NGAYHENBANGIAO"), DateUtils.SDF_DDMMYYYY));
			map.put("ngaydenghibangiao",DateUtils.formatDate(rs.getDate("NGAYDENGHIBANGIAO"), DateUtils.SDF_DDMMYYYY));
			result.add(map);
			i++;
		}
		stmt.close();
		connection.close();
		return result;
	}
	
	public TuyenKenhDeXuatDTO findById(String id) {
		return (TuyenKenhDeXuatDTO) this.jdbcTemplate.queryForObject("select * from TUYENKENHDEXUAT where id = ?" ,new Object[] {id}, new RowMapper() {
			@Override
			public Object mapRow(ResultSet rs, int arg1) throws SQLException {
				return TuyenKenhDeXuatDTO.mapObject(rs);
			}
		});
	}
	
	private static final String SQL_SAVE_TUYENKENHDEXUAT = "{ ? = call SAVE_TUYENKENHDEXUAT(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?) }";
	public String save(TuyenKenh tuyenKenh,TuyenKenhDeXuatDTO tuyenKenhDeXuatDTO,int soluong_old) throws Exception {
		Connection connection = this.jdbcDatasource.getConnection();
		CallableStatement stmt = connection.prepareCall(SQL_SAVE_TUYENKENHDEXUAT);
		stmt.registerOutParameter(1, OracleTypes.VARCHAR);
		stmt.setString(2, tuyenKenhDeXuatDTO.getId());
		stmt.setString(3, tuyenKenh.getId());
		stmt.setString(4, tuyenKenh.getMadiemdau());
		stmt.setString(5, tuyenKenh.getMadiemcuoi());
		stmt.setString(6, tuyenKenh.getGiaotiep_id());
		stmt.setString(7, tuyenKenh.getDuan_id());
		stmt.setString(8, tuyenKenh.getPhongban_id());
		stmt.setString(9, tuyenKenh.getDoitac_id());
		stmt.setString(10, String.valueOf(tuyenKenh.getDungluong()));
		stmt.setString(11, tuyenKenhDeXuatDTO.getNgaydenghibangiao());
		stmt.setString(12, tuyenKenhDeXuatDTO.getNgayhenbangiao());
		stmt.setString(13, tuyenKenhDeXuatDTO.getThongtinlienhe());
		stmt.setInt(14, tuyenKenhDeXuatDTO.getSoluong());
		stmt.setInt(15, soluong_old);
		stmt.setString(16, tuyenKenh.getUsercreate());
		stmt.setString(17, tuyenKenh.getTimecreate());
		stmt.execute();
		String rs = stmt.getString(1);
		stmt.close();
		connection.close();
		return rs;
	}
	
	public void deleteByIds(String[] ids,String username) throws SQLException {
		Connection connection = this.jdbcDatasource.getConnection();
		System.out.println("***BEGIN TuyenKenhDeXuatDAO.deleteByIds***");
		ArrayDescriptor descriptor = ArrayDescriptor.createDescriptor( "TABLE_VARCHAR", connection );
		ARRAY array =new ARRAY( descriptor, connection, ids );
		CallableStatement stmt = connection.prepareCall("call PROC_DELETE_TUYENKENHDEXUAT(?,?,?)");
		stmt.setArray(1, array);
		stmt.setString(2, username);
		stmt.setLong(3, System.currentTimeMillis());
		stmt.execute();
		stmt.close();
		connection.close();
	}
	public void updateDexuatByIds(String[] ids,String dexuat_id) {
		String str = StringUtils.join(ids, ",");
		this.jdbcTemplate.update("update TUYENKENHDEXUAT set DEXUAT_ID = ? where ID in ("+str+")", new Object[] {dexuat_id});
	}
	public void updateBangiaoByIds(String[] ids,String bangiao_id) {
		String str = StringUtils.join(ids, ",");
		this.jdbcTemplate.update("update TUYENKENH set TRANGTHAI = 3,FLAG = 1 where ID in ( select TUYENKENH_ID from TUYENKENHDEXUAT where ID in("+str+") )");
		this.jdbcTemplate.update("update TUYENKENHDEXUAT set BANGIAO_ID = ?, TRANGTHAI = 2 where ID in ("+str+")", new Object[] {bangiao_id});
	}
	@SuppressWarnings("unchecked")
	public Map<String,String> findTuyenKenhDangDeXuat(String tuyenkenhId) throws Exception {
		List<Map<String,String>> list = this.jdbcTemplate.query("select * from TUYENKENHDEXUAT where DELETED = 0 and TRANGTHAI = 0 and TUYENKENH_ID=?" ,new Object[] {tuyenkenhId}, new RowMapper() {
			@Override
			public Object mapRow(ResultSet rs, int arg1) throws SQLException {
				return VMSUtil.resultSetToMap(rs);
			}
		});
		if(list.size()>1) throw new Exception("SYSTEM_ERROR");
		if(list.size()>0) return list.get(0);
		return null;
	}
}