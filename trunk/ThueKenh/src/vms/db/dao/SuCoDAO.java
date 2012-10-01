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

import vms.db.dto.SuCoDTO;
import vms.db.dto.TuyenKenh;
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
	
	private static final String SQL_SAVE_SUCO = "{ ? = call SAVE_SUCOKENH(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?) }";
	public String save(SuCoDTO dto) throws Exception {
		System.out.println("begin call SAVE_SUCOKENH");
		Connection connection = jdbcTemplate.getDataSource().getConnection();
		CallableStatement stmt = connection.prepareCall(SQL_SAVE_SUCO);
		stmt.registerOutParameter(1, OracleTypes.VARCHAR);
		stmt.setString(2, dto.getId());
		stmt.setString(3, dto.getTuyenkenh_id());
		stmt.setString(4, dto.getPhuluc_id());
		stmt.setString(5, dto.getThanhtoan_id());
		stmt.setDate(6,DateUtils.convert(DateUtils.parseDate(dto.getThoidiembatdau(), "dd/MM/yyyy HH:mm:ss")) );
		stmt.setDate(7,DateUtils.convert(DateUtils.parseDate(dto.getThoidiemketthuc(), "dd/MM/yyyy HH:mm:ss")) );
		stmt.setString(8, dto.getThoigianmll().toString());
		stmt.setString(9, dto.getNguyennhan());
		stmt.setString(10, dto.getPhuonganxuly());
		stmt.setString(11, dto.getNguoixacnhan());
		stmt.setString(12, String.valueOf(dto.getGiamtrumll()));
		stmt.setString(13, dto.getTrangthai().toString());
		stmt.setString(14, dto.getUsercreate());
		stmt.setString(15, dto.getTimecreate());
		stmt.setString(16, dto.getDeleted().toString());
		stmt.setString(17, dto.getFilename());
		stmt.setString(18, dto.getFilepath());
		stmt.setString(19, dto.getFilesize());
		stmt.execute();
		System.out.println("end call SAVE_SUCOKENH");
		return stmt.getString(1);
	}
	
	private static final String SQL_FN_FIND_SUCO = "{ ? = call FN_FIND_SUCO(?,?,?,?,?,?,?,?,?,?) }";
	public List<FN_FIND_SUCO> findSuCo(int iDisplayStart,int iDisplayLength,Map<String, String> conditions) throws SQLException {
		Connection connection = jdbcDatasource.getConnection();
		CallableStatement stmt = connection.prepareCall(SQL_FN_FIND_SUCO);
		stmt.registerOutParameter(1, OracleTypes.CURSOR);
		stmt.setInt(2, iDisplayStart);
		stmt.setInt(3, iDisplayLength);
		stmt.setString(4, conditions.get("tuyenkenh_id"));
		stmt.setString(5, conditions.get("madiemdau"));
		stmt.setString(6, conditions.get("madiemcuoi"));
		stmt.setString(7, conditions.get("dungluong"));
		stmt.setString(8, conditions.get("thoidiembatdau"));
		stmt.setString(9, conditions.get("thoidiemketthuc"));
		stmt.setString(10, conditions.get("nguoixacnhan"));
		stmt.setString(11, conditions.get("bienbanvanhanh_id"));
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
		this.jdbcTemplate.update("update SUCOKENH set DELETED = 1 where ID in ("+str+")");
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
				map.put("thoidiembatdau",DateUtils.formatDate(rs.getDate("thoidiembatdau"), DateUtils.SDF_DDMMYYYYHHMMSS2));
				map.put("thoidiemketthuc",DateUtils.formatDate(rs.getDate("thoidiemketthuc"), DateUtils.SDF_DDMMYYYYHHMMSS2));
				map.put("timecreate",DateUtils.formatDate(rs.getDate("timecreate"), DateUtils.SDF_DDMMYYYY));
				return map;
			}
		});
		if(list.isEmpty()) return null;
		return list.get(0);
	}
}
