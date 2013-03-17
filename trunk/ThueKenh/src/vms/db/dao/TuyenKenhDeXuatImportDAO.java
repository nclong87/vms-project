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
import oracle.sql.ARRAY;
import oracle.sql.ArrayDescriptor;

import org.apache.commons.lang3.StringUtils;
import org.springframework.jdbc.core.JdbcTemplate;

import vms.db.dto.TuyenKenhDeXuatImportDTO;
import vms.utils.DateUtils;
import vms.utils.VMSUtil;

public class TuyenKenhDeXuatImportDAO {
	private JdbcTemplate jdbcTemplate;
	private DataSource jdbcDatasource;
	public TuyenKenhDeXuatImportDAO(DaoFactory daoFactory) {
		this.jdbcTemplate = daoFactory.getJdbcTemplate();
		this.jdbcDatasource = daoFactory.getJdbcDataSource();
	}
	public static Map<String, Object> resultSetToMap(ResultSet rs) throws SQLException {
    	Map<String, Object> map = VMSUtil.resultSetToMap(rs);
    	return map;
    	
    } 
	private static final String SQL_SAVE_TUYENKENHDEXUAT_IMPORT = "{ call SAVE_TUYENKENHDEXUAT_IMPORT(?,?,?,?,?,?,?,?,?,?,?,?,?,?) }";
	public void save(TuyenKenhDeXuatImportDTO dto) throws Exception {
		Connection connection = jdbcTemplate.getDataSource().getConnection();
		CallableStatement stmt = connection.prepareCall(SQL_SAVE_TUYENKENHDEXUAT_IMPORT);
		stmt.setInt(1, dto.getStt());
		stmt.setString(2, dto.getMadiemdau());
		stmt.setString(3, dto.getMadiemcuoi());
		stmt.setString(4, dto.getGiaotiep_ma());
		stmt.setString(5, dto.getDuan_ma());
		stmt.setString(6, dto.getDonvinhankenh());
		stmt.setString(7, dto.getDoitac_ma());
		stmt.setString(8, dto.getDungluong());
		stmt.setString(9, dto.getSoluongdexuat());
		stmt.setString(10, DateUtils.parseStringDateSQL(dto.getNgayhenbangiao(), "dd/MM/yyyy"));
		stmt.setString(11, DateUtils.parseStringDateSQL(dto.getNgaydenghibangiao(), "dd/MM/yyyy"));
		stmt.setString(12, dto.getDuplicate());
		stmt.setString(13, dto.getTuyenkenh_id());
		stmt.setDate(14, DateUtils.convertToSQLDate(dto.getDateimport()) );
		stmt.execute();
		stmt.close();
		connection.close();
	}
	
	public void clear() {
		this.jdbcTemplate.execute("truncate table TUYENKENHDEXUAT_IMPORT drop storage");
	}
	
	private static final String SQL_FIND_TUYENKENHDEXUATIMPORT = "{ ? = call FIND_TUYENKENHDEXUATIMPORT(?,?) }";
	public List<Map<String,Object>> search(int iDisplayStart,int iDisplayLength) throws SQLException {
		Connection connection = jdbcDatasource.getConnection();
		CallableStatement stmt = connection.prepareCall(SQL_FIND_TUYENKENHDEXUATIMPORT);
		stmt.registerOutParameter(1, OracleTypes.CURSOR);
		stmt.setInt(2, iDisplayStart);
		stmt.setInt(3, iDisplayLength);
		stmt.execute();
		ResultSet rs = (ResultSet) stmt.getObject(1);
		List<Map<String,Object>> result = new ArrayList<Map<String,Object>>();
		int i = 1;
		while(rs.next()) {
			Map<String,Object> map = TuyenKenhDeXuatImportDAO.resultSetToMap(rs);
			//map.put("stt", i);
			result.add(map);
			i++;
		}
		stmt.close();
		connection.close();
		return result;
	}
	
	private static final String SQL_PROC_IMPORT_TUYENKENHDEXUAT = "{ call PROC_IMPORT_TUYENKENHDEXUAT(?,?,?) }";
	public void importTuyenkenhDeXuat(String[] ids,String account) throws SQLException {
		Connection connection = jdbcDatasource.getConnection();
		ArrayDescriptor descriptor = ArrayDescriptor.createDescriptor( "TABLE_NUMBER", connection );
		ARRAY array =new ARRAY( descriptor, connection, ids );
		CallableStatement stmt = connection.prepareCall(SQL_PROC_IMPORT_TUYENKENHDEXUAT);
		stmt.setArray(1, array);
		stmt.setString(2, account);
		stmt.setDate(3, DateUtils.convertToSQLDate(new Date()));
		stmt.execute();
		stmt.close();
		connection.close();
	}
	
	public void deleteByIds(String[] ids) {
		String str = StringUtils.join(ids, ",");
		this.jdbcTemplate.update("delete from TUYENKENHDEXUAT_IMPORT where ID in ("+str+")");
	}
}