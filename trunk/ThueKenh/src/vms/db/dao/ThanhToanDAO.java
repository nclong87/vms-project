package vms.db.dao;


import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.Map;
import javax.sql.DataSource;
import oracle.jdbc.OracleTypes;

import org.apache.commons.lang3.StringUtils;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.core.RowMapper;

import vms.db.dto.BienBanVanHanhKenhDTO;
import vms.db.dto.ThanhToanDTO;
import vms.db.dto.SuCoDTO;
import vms.utils.DateUtils;
import vms.utils.StringUtil;
import vms.utils.VMSUtil;

public class ThanhToanDAO {
	private JdbcTemplate jdbcTemplate;
	private DataSource jdbcDatasource;
	public ThanhToanDAO(DaoFactory daoFactory) {
		this.jdbcTemplate = daoFactory.getJdbcTemplate();
		this.jdbcDatasource = daoFactory.getJdbcDataSource();
	}
	
	private static final String SQL_SAVE_HOSOTHANHTOAN = "{ ? = call SAVE_HOSOTHANHTOAN(?,?,?,?,?,?,?,?,?,?,?) }";
	public String save(ThanhToanDTO dto) throws Exception {
		System.out.println("begin call SAVE_HOSOTHANHTOAN");
		Connection connection = jdbcTemplate.getDataSource().getConnection();
		CallableStatement stmt = connection.prepareCall(SQL_SAVE_HOSOTHANHTOAN);
		stmt.registerOutParameter(1, OracleTypes.VARCHAR);
		stmt.setString(2, dto.getId());
		stmt.setString(3, dto.getNgaychuyenkt());
		stmt.setString(4, dto.getTrangthai().toString());		
		stmt.setString(5, dto.getUsercreate());		
		stmt.setString(6, dto.getTimecreate());	
		stmt.setString(7, dto.getDeleted().toString());
		stmt.setString(8, dto.getFilename());
		stmt.setString(9, dto.getFilepath());
		stmt.setString(10, dto.getFilesize());
		stmt.setString(11, dto.getSohoso());	
		stmt.setString(12, dto.getDoisoatcuoc_id());
		stmt.execute();
		System.out.println("end call SAVE_HOSOTHANHTOAN");
		String s = stmt.getString(1);
		System.out.println("i:"+s);
		stmt.close();
		connection.close();
		return s;
	}
	
	private static final String SQL_FIND_HOSOTHANHTOAN = "{ ? = call FIND_HOSOTHANHTOAN(?,?,?,?,?,?) }";
	public List<Map<String,Object>> search(int iDisplayStart,int iDisplayLength,Map<String, String> conditions) throws SQLException {
		Connection connection = jdbcDatasource.getConnection();
		CallableStatement stmt = connection.prepareCall(SQL_FIND_HOSOTHANHTOAN);
		stmt.registerOutParameter(1, OracleTypes.CURSOR);
		stmt.setInt(2, iDisplayStart);
		stmt.setInt(3, iDisplayLength);
		stmt.setString(4, conditions.get("sohoso"));
		String ngaychuyenhosotu="";
		if(conditions.get("ngaychuyenhosotu")!=null)
			ngaychuyenhosotu=DateUtils.parseStringDateSQL(conditions.get("ngaychuyenhosotu"), "dd/MM/yyyy");
		stmt.setString(5, ngaychuyenhosotu);
		String ngaychuyenhosoden="";
		if(conditions.get("ngaychuyenhosoden")!=null)
			ngaychuyenhosoden=DateUtils.parseStringDateSQL(conditions.get("ngaychuyenhosoden"), "dd/MM/yyyy");
		stmt.setString(6, ngaychuyenhosoden);
		stmt.setString(7,conditions.get("trangthai"));
		stmt.execute();
		ResultSet rs = (ResultSet) stmt.getObject(1);
		List<Map<String,Object>> result = new ArrayList<Map<String,Object>>();
		int i = 1;
		while(rs.next()) {
			Map<String,Object> map = VMSUtil.resultSetToMap(rs);
			map.put("stt", i);
			map.put("ngaychuyenkt", DateUtils.formatDate(rs.getDate("ngaychuyenkt"), DateUtils.SDF_DDMMYYYY));
			result.add(map);
			i++;
		}
		stmt.close();
		connection.close();
		return result;
	}
	
	public ThanhToanDTO findById(String id) {
		return (ThanhToanDTO) this.jdbcTemplate.queryForObject("SELECT * FROM THANHTOAN WHERE id = ? AND DELETED = 0" ,new Object[] {id}, new RowMapper() {
			@Override
			public Object mapRow(ResultSet rs, int arg1) throws SQLException {
				return ThanhToanDTO.mapObject(rs);
			}
		});
	}
	
	public void deleteByIds(String[] ids) {
		String str = StringUtils.join(ids, ",");
		this.jdbcTemplate.update("update THANHTOAN set DELETED= "+System.currentTimeMillis()+" where ID in ("+str+")");
	}
	
	private static final String SQL_DETAIL_HOSOTHANHTOAN = " SELECT tt.*,d.thanhtien,d.tungay,d.giamtrumll "+
                                                 		   " FROM THANHTOAN tt "+
                                                  		   " LEFT JOIN DOISOATCUOC d ON d.ID = tt.DOISOATCUOC_ID "+
                                                  	       " WHERE tt.id=? AND tt.DELETED=0";
	@SuppressWarnings("unchecked")
	public Map<String,Object> getDetail(String id) {
		List<Map<String,Object>> list =  this.jdbcTemplate.query(SQL_DETAIL_HOSOTHANHTOAN ,new Object[] {id}, new RowMapper() {
			@Override
			public Object mapRow(ResultSet rs, int arg1) throws SQLException {
				Map<String,Object> map = VMSUtil.resultSetToMap(rs);
				map.put("ngaychuyenkt", DateUtils.formatDate(rs.getDate("ngaychuyenkt"), DateUtils.SDF_DDMMYYYY));
				map.put("timecreate",DateUtils.formatDate(rs.getDate("timecreate"), DateUtils.SDF_DDMMYYYY));
				return map;
			}
		});
		if(list.isEmpty()) return null;
		return list.get(0);
	}
	@SuppressWarnings("unchecked")
	public ThanhToanDTO findBySoHoSo(String sohoso) {
		if(StringUtil.isEmpty(sohoso))
			return null;
		List<ThanhToanDTO> list =  this.jdbcTemplate.query("SELECT * FROM THANHTOAN WHERE SOHOSO = ? AND DELETED = 0" ,
				new Object[] {sohoso}, new RowMapper() {
			@Override
			public Object mapRow(ResultSet rs, int arg1) throws SQLException {
				return ThanhToanDTO.mapObject(rs);
			}
		});
		if(list.isEmpty()) return null;
		return list.get(0);
	}
}
