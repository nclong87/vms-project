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

import vms.db.dto.SuCoDTO;
import vms.utils.DateUtils;
import vms.utils.VMSUtil;
import vms.web.models.FN_FIND_SUCO;

public class SuCoDAO {
	private JdbcTemplate jdbcTemplate;
	private DataSource jdbcDatasource;
	public SuCoDAO(DaoFactory daoFactory) {
		this.jdbcTemplate = daoFactory.getJdbcTemplate();
		this.jdbcDatasource = daoFactory.getJdbcDataSource();
	}
	
	private static final String SQL_SAVE_SUCO = "{ ? = call SAVE_SUCOKENH(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?) }";
	public String save(SuCoDTO dto) throws Exception {
		System.out.println("begin call SAVE_SUCOKENH");
		System.out.println("dto.getPhuluc_id() ="+dto.getPhuluc_id());
		Connection connection = jdbcTemplate.getDataSource().getConnection();
		CallableStatement stmt = connection.prepareCall(SQL_SAVE_SUCO);
		stmt.registerOutParameter(1, OracleTypes.VARCHAR);
		stmt.setString(2, dto.getId());
		stmt.setString(3, dto.getTuyenkenh_id());
		stmt.setString(4, dto.getLoaisuco());
		stmt.setString(5, dto.getPhuluc_id());
		stmt.setString(6, dto.getThanhtoan_id());
		stmt.setString(7,dto.getThoidiembatdau());
		stmt.setString(8,dto.getThoidiemketthuc());
		stmt.setString(9, String.valueOf(dto.getThoigianmll()));
		stmt.setString(10, dto.getNguyennhan());
		stmt.setString(11, dto.getPhuonganxuly());
		stmt.setString(12, dto.getNguoixacnhan());
		stmt.setString(13, String.valueOf(dto.getGiamtrumll()));
		stmt.setString(14, dto.getTrangthai().toString());
		stmt.setString(15, dto.getUsercreate());
		stmt.setString(16, dto.getTimecreate());
		stmt.setString(17, dto.getDeleted().toString());
		stmt.setString(18, dto.getFilename());
		stmt.setString(19, dto.getFilepath());
		stmt.setString(20, dto.getFilesize());
		stmt.setString(21,dto.getBienbanvanhanh_id());
		stmt.execute();
		System.out.println("end call SAVE_SUCOKENH");
		String s = stmt.getString(1);
		stmt.close();
		connection.close();
		return s;
	}
	
	private static final String SQL_FN_FIND_SUCO = "{ ? = call FN_FIND_SUCO(?,?,?,?,?,?,?,?,?,?,?,?,?) }";
	public List<FN_FIND_SUCO> findSuCo(int iDisplayStart,int iDisplayLength,Map<String, String> conditions) throws SQLException {
		System.out.println("Begin FindSuCo");
		Connection connection = jdbcDatasource.getConnection();
		CallableStatement stmt = connection.prepareCall(SQL_FN_FIND_SUCO);
		stmt.registerOutParameter(1, OracleTypes.CURSOR);
		stmt.setInt(2, iDisplayStart);
		stmt.setInt(3, iDisplayLength);
		stmt.setString(4, conditions.get("tuyenkenh_id"));
		stmt.setString(5, conditions.get("loaisuco"));
		stmt.setString(6, conditions.get("madiemdau"));
		stmt.setString(7, conditions.get("madiemcuoi"));
		stmt.setString(8, conditions.get("dungluong"));
		System.out.println("toidiembatdautu:"+conditions.get("thoidiembatdautu"));
		String thoidiembatdautu="";
		if(conditions.get("thoidiembatdautu")!=null)
			thoidiembatdautu=String.valueOf(DateUtils.parseDate(conditions.get("thoidiembatdautu"), "dd/MM/yyyy HH:mm:ss").getTime());
		stmt.setString(9, thoidiembatdautu);
		String thoidiembatdauden="";
		if(conditions.get("thoidiembatdauden")!=null)
			thoidiembatdauden=String.valueOf(DateUtils.parseDate(conditions.get("thoidiembatdauden"), "dd/MM/yyyy HH:mm:ss").getTime());
		stmt.setString(10, thoidiembatdauden);
		String thoidiemketthuctu="";
		if(conditions.get("thoidiemketthuctu")!=null)
			thoidiemketthuctu=String.valueOf(DateUtils.parseDate(conditions.get("thoidiemketthuctu"), "dd/MM/yyyy HH:mm:ss").getTime());
		stmt.setString(11, thoidiemketthuctu);
		String thoidiemketthucden="";
		if(conditions.get("thoidiemketthucden")!=null)
			thoidiemketthucden=String.valueOf(DateUtils.parseDate(conditions.get("thoidiemketthucden"), "dd/MM/yyyy HH:mm:ss").getTime());
		stmt.setString(12, thoidiemketthucden);
		stmt.setString(13, conditions.get("nguoixacnhan"));
		stmt.setString(14, conditions.get("bienbanvanhanh_id"));
		stmt.execute();
		ResultSet rs = (ResultSet) stmt.getObject(1);
		List<FN_FIND_SUCO> result = new ArrayList<FN_FIND_SUCO>();
		while(rs.next()) {
			result.add(FN_FIND_SUCO.mapObject(rs));
		}
		stmt.close();
		connection.close();
		return result;
	}
	
	public SuCoDTO findById(String id) {
		return (SuCoDTO) this.jdbcTemplate.queryForObject("SELECT * FROM SUCOKENH WHERE id = ? AND DELETED = 0" ,new Object[] {id}, new RowMapper() {
			@Override
			public Object mapRow(ResultSet rs, int arg1) throws SQLException {
				return SuCoDTO.mapObject(rs);
			}
		});
	}
	
	public void deleteByIds(String[] ids) {
		String str = StringUtils.join(ids, ",");
		this.jdbcTemplate.update("update SUCOKENH set DELETED= "+System.currentTimeMillis()+" where ID in ("+str+")");
	}
	
	private static final String SQL_DETAIL_SUCO = " SELECT t.ID tuyenkenh_id,t.MADIEMDAU,t.MADIEMCUOI,gt.LOAIGIAOTIEP,t.DUNGLUONG,t.SOLUONG,sc.THOIDIEMBATDAU,sc.THOIDIEMKETTHUC, "+
													"sc.THOIGIANMLL,sc.NGUYENNHAN,sc.PHUONGANXULY,sc.NGUOIXACNHAN,sc.FILENAME,sc.FILEPATH,sc.FILESIZE,sc.USERCREATE,sc.TIMECREATE "+
                                                 	"FROM SUCOKENH sc "+
                                                  		"LEFT JOIN TUYENKENH t ON sc.TUYENKENH_ID = t.ID "+
                                                  		"LEFT JOIN LOAIGIAOTIEP gt ON t.GIAOTIEP_ID=gt.ID "+
                                                  	"WHERE sc.id=? AND sc.DELETED=0";
	@SuppressWarnings("unchecked")
	public Map<String,Object> getDetail(String id) {
		List<Map<String,Object>> list =  this.jdbcTemplate.query(SQL_DETAIL_SUCO ,new Object[] {id}, new RowMapper() {
			@Override
			public Object mapRow(ResultSet rs, int arg1) throws SQLException {
				Map<String,Object> map = VMSUtil.resultSetToMap(rs);
				map.put("thoidiembatdau",DateUtils.formatDate(new Date(rs.getLong("THOIDIEMBATDAU")), DateUtils.SDF_DDMMYYYYHHMMSS2));
				map.put("thoidiemketthuc",DateUtils.formatDate(new Date(rs.getLong("THOIDIEMKETTHUC")), DateUtils.SDF_DDMMYYYYHHMMSS2));
				map.put("timecreate",DateUtils.formatDate(rs.getDate("timecreate"), DateUtils.SDF_DDMMYYYY));
				return map;
			}
		});
		if(list.isEmpty()) return null;
		return list.get(0);
	}
	
	private static final String SQL_FN_FIND_SUCO_BY_BIENBANVANHANH = "{ ? = call FN_FIND_SUCO_BY_BIENBANVANHANH(?) }";
	public List<SuCoDTO> findSuCoByBienBanVanHanh(String bienbanvanhanh_id) throws SQLException {
		System.out.println("Begin FindSuCoByBienBanVanHanh");
		Connection connection = jdbcDatasource.getConnection();
		CallableStatement stmt = connection.prepareCall(SQL_FN_FIND_SUCO_BY_BIENBANVANHANH);
		stmt.registerOutParameter(1, OracleTypes.CURSOR);
		System.out.println("bienbanvanhanh_id:"+bienbanvanhanh_id);
		stmt.setString(2, bienbanvanhanh_id);
		stmt.execute();
		ResultSet rs = (ResultSet) stmt.getObject(1);
		List<SuCoDTO> result = new ArrayList<SuCoDTO>();
		while(rs.next()) {
			result.add(SuCoDTO.mapObject(rs));
		}
		stmt.close();
		connection.close();
		return result;
	}
	
	private static final String SQL_FN_FIND_SUCO_BY_THANHTOAN_ID = "{ ? = call FN_FIND_SUCO_BY_THANHTOAN(?) }";
	public List<SuCoDTO> findSuCoByThanhToanId(String thanhtoan_id) throws SQLException {
		System.out.println("Begin FindSuCoByThanhtoanId");
		Connection connection = jdbcDatasource.getConnection();
		CallableStatement stmt = connection.prepareCall(SQL_FN_FIND_SUCO_BY_THANHTOAN_ID);
		stmt.registerOutParameter(1, OracleTypes.CURSOR);
		System.out.println("thanhtoan_id:"+thanhtoan_id);
		stmt.setString(2, thanhtoan_id);
		stmt.execute();
		ResultSet rs = (ResultSet) stmt.getObject(1);
		List<SuCoDTO> result = new ArrayList<SuCoDTO>();
		while(rs.next()) {
			result.add(SuCoDTO.mapObject(rs));
		}
		stmt.close();
		connection.close();
		return result;
	}
	
	private static final String SQL_FN_FIND_SUCO_BY_DOISOATCUOC = "{ ? = call FN_FIND_SUCO_BY_DSCUOC(?,?,?) }";
	public List<Map<String,Object>> findSuCoByDoiSoatCuoc(int iDisplayStart,int iDisplayLength,Map<String, String> conditions) throws SQLException {
		Connection connection = jdbcDatasource.getConnection();
		CallableStatement stmt = connection.prepareCall(SQL_FN_FIND_SUCO_BY_DOISOATCUOC);
		stmt.registerOutParameter(1, OracleTypes.CURSOR);
		stmt.setInt(2, iDisplayStart);
		stmt.setInt(3, iDisplayLength);
		stmt.setString(4, conditions.get("doisoatcuoc_id"));
		stmt.execute();
		ResultSet rs = (ResultSet) stmt.getObject(1);
		List<Map<String,Object>> result = new ArrayList<Map<String,Object>>();
		int i = 1;
		while(rs.next()) {
			Map<String,Object> map = VMSUtil.resultSetToMap(rs);
			map.put("stt", i);
			map.put("thoidiembatdau",DateUtils.formatDate(new Date(rs.getLong("THOIDIEMBATDAU")), DateUtils.SDF_DDMMYYYYHHMMSS2));
			map.put("thoidiemketthuc",DateUtils.formatDate(new Date(rs.getLong("THOIDIEMKETTHUC")), DateUtils.SDF_DDMMYYYYHHMMSS2));
			result.add(map);
			i++;
		}
		stmt.close();
		connection.close();
		return result;
	}
}
