package vms.db.dao;


import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.ResultSetMetaData;
import java.sql.SQLException;
import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;
import javax.sql.DataSource;
import oracle.jdbc.OracleTypes;

import org.apache.commons.lang3.StringUtils;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.core.RowMapper;
import vms.db.dto.TuyenKenh;
import vms.utils.DateUtils;
import vms.utils.VMSUtil;

public class TuyenkenhDao {
	private JdbcTemplate jdbcTemplate;
	private DataSource jdbcDatasource;
	private DaoFactory daoFactory;
	public TuyenkenhDao(DaoFactory daoFactory) {
		this.jdbcTemplate = daoFactory.getJdbcTemplate();
		this.jdbcDatasource = daoFactory.getJdbcDataSource();
		this.daoFactory = daoFactory;
	}
	public static Map<String, Object> resultSetToMap(ResultSet rs) throws SQLException {
    	Map<String, Object> map = VMSUtil.resultSetToMap(rs);
    	return map;
    	
    } 
	private static final String SQL_FN_FIND_TUYENKENH = "{ ? = call FN_FIND_TUYENKENH(?,?,?,?,?,?,?,?,?,?,?,?,?,?) }";
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
		stmt.setString(14, conditions.get("flag"));
		stmt.setString(15, conditions.get("phuluc_id"));
		stmt.execute();
		ResultSet rs = (ResultSet) stmt.getObject(1);
		List<Map<String,Object>> result = new ArrayList<Map<String,Object>>();
		int i = 1;
		while(rs.next()) {
			Map<String,Object> map = TuyenkenhDao.resultSetToMap(rs);
			map.put("stt", i);
			result.add(map);
			i++;
		}
		stmt.close();
		connection.close();
		return result;
	}
	
	private static final String SQL_FN_FIND_TUYENKENHSUCO = "{ ? = call FN_FIND_TUYENKENHSUCO(?,?,?,?,?,?,?,?,?,?,?,?,?) }";
	public List<Map<String,Object>> findTuyenkenhSuCo(int iDisplayStart,int iDisplayLength,Map<String, String> conditions) throws SQLException {
		Connection connection = jdbcDatasource.getConnection();
		CallableStatement stmt = connection.prepareCall(SQL_FN_FIND_TUYENKENHSUCO);
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
		stmt.setString(14, conditions.get("flag"));
		stmt.execute();
		ResultSet rs = (ResultSet) stmt.getObject(1);
		List<Map<String,Object>> result = new ArrayList<Map<String,Object>>();
		int i = 1;
		while(rs.next()) {
			Map<String,Object> map = TuyenkenhDao.resultSetToMap(rs);
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
	public TuyenKenh findByKey(String madiemdau,String madiemcuoi,String giaotiep_id,Double dungluong) {
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
	
	private static final String SQL_SAVE_TUYENKENH = "{ ? = call SAVE_TUYENKENH(?,?,?,?,?,?,?,?,?,?,?,?,?,?) }";
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
		Timestamp timestamp = new Timestamp(System.currentTimeMillis());
		stmt.setTimestamp(13, timestamp);
		stmt.setString(14, String.valueOf(dto.getDeleted()));
		stmt.setString(15, String.valueOf(dto.getLoaikenh()));
		stmt.execute();
		String id = stmt.getString(1);
		stmt.close();
		connection.close();
		return id;
	}
	
	public void deleteByIds(String[] ids, Map<String,Object> account) {
		List<String> lstId = new ArrayList<String>();
		for(int i=0;i<ids.length;i++) {
			lstId.add(ids[i]);
			ids[i] = "'"+ids[i]+"'";
		}
		String str = StringUtils.join(ids, ",");
		System.out.println(str);
		long time = System.currentTimeMillis();
		String query = "update TUYENKENH set DELETED = "+time+" where ID in ("+str+")";
		this.jdbcTemplate.update(query);
		LichSuTuyenKenhDAO lichSuTuyenKenhDAO = new LichSuTuyenKenhDAO(daoFactory);
		for (String tuyenkenh_id : lstId) {		
			lichSuTuyenKenhDAO.insertLichSu(account.get("username").toString(), tuyenkenh_id, 2, "");
		}
		
	}
	
	private static final String SQL_DETAIL_TUYENKENH = "select t.*,TENDUAN,TENDOITAC,LOAIGIAOTIEP,TENPHONGBAN from TUYENKENH t left join LOAIGIAOTIEP t0 on t.GIAOTIEP_ID = t0.ID left join DUAN t1 on t.DUAN_ID = t1.ID left join PHONGBAN t2 on t.PHONGBAN_ID = t2.ID left join DOITAC t3 on t.DOITAC_ID = t3.ID where t.ID = ?";
	@SuppressWarnings("unchecked")
	public Map<String,Object> getDetail(String id) {
		List<Map<String,Object>> list =  this.jdbcTemplate.query(SQL_DETAIL_TUYENKENH ,new Object[] {id}, new RowMapper() {
			@Override
			public Object mapRow(ResultSet rs, int arg1) throws SQLException {
				return TuyenkenhDao.resultSetToMap(rs);
			}
		});
		if(list.isEmpty()) return null;
		return list.get(0);
	}
	
	private static String resultSetToXMLWithProperties(ResultSet rs) {
    	StringBuffer buffer = new StringBuffer(512);
    	try {
			ResultSetMetaData resultSetMetaData = rs.getMetaData();
			int n = resultSetMetaData.getColumnCount();
			for(int i=1;i<=n;i++) {
				String tagName = resultSetMetaData.getColumnName(i).toLowerCase();
				String data = "";
				if(resultSetMetaData.getColumnType(i) == java.sql.Types.DATE) {
					data = DateUtils.formatDate(rs.getDate(i), DateUtils.SDF_DDMMYYYYHHMMSS3);
				} else {
					data = rs.getString(i)==null?"":rs.getString(i);
					if(tagName.compareTo("trangthai")==0)
					{
						if(data.compareTo("0")==0)
							data="Không hoạt động";
						else if(data.compareTo("1")==0)
							data="Đang bàn giao";
						else if(data.compareTo("2")==0)
							data="Đang cập nhật số lượng";
						else if(data.compareTo("3")==0)
							data="Đã bàn giao";
						else if(data.compareTo("4")==0)
							data="Đang hoạt động";
					}
				}
				buffer.append("<cell hid=\""+tagName+"\" "+">"+data+"</cell>");
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
    	return buffer.toString();
    }
	
	private static final String SQL_EXPORT_TUYENKENH = "{ ? = call FN_EXPORT_TUYENKENH(?,?) }";
	public String exportTuyenkenh(String[] fields,String[] fieldNames) throws Exception {
		Connection connection = jdbcTemplate.getDataSource().getConnection();
		if(connection == null)
			connection = this.jdbcDatasource.getConnection();
		System.out.println("***BEGIN exportTuyenkenh***");
		CallableStatement stmt = connection.prepareCall(SQL_EXPORT_TUYENKENH);
		stmt.registerOutParameter(1, OracleTypes.CURSOR);
		stmt.setString(2, StringUtils.join(fields, ","));
		int flag = 0;
		for(int i=0;i<fields.length;i++) {
			if(fields[i].equals("tenphuluc") || fields[i].equals("sohopdong")) {
				flag = 1;
				break;
			}
		}
		stmt.setInt(3, flag);
		stmt.execute();
		ResultSet rs = (ResultSet) stmt.getObject(1);
		StringBuffer stringBuffer = new StringBuffer(1024);
		stringBuffer.append("<root>");
		stringBuffer.append("<header>");
		for(int i=0;i<fields.length;i++)
		{
			if(fields[i].compareTo("soluong")==0)
				stringBuffer.append("<cell id=\""+fields[i]+"\" type=\"Number\" style=\"Number\">"+fieldNames[i]+"</cell>");
			else if(fields[i].compareTo("dungluong")==0)
				stringBuffer.append("<cell id=\""+fields[i]+"\" type=\"Number\" style=\"Double\">"+fieldNames[i]+"</cell>");
			else
				stringBuffer.append("<cell id=\""+fields[i]+"\" type=\"String\" style=\"Text\">"+fieldNames[i]+"</cell>");
		}
		stringBuffer.append("</header>");
		stringBuffer.append("<rows>");
		while(rs.next()) {
			stringBuffer.append("<row>");
			stringBuffer.append(TuyenkenhDao.resultSetToXMLWithProperties(rs));
			stringBuffer.append("</row>");
		}
		stringBuffer.append("</rows>");
		stringBuffer.append("</root>");
		stmt.close();
		connection.close();
		return stringBuffer.toString();
	}
	
	public void runScript(String sql) {
		this.jdbcTemplate.execute(sql);
		//("update TUYENKENH set NGAYBATDAU = ?,LOAIKENH = ? where ID = ?", new Object[] {});
	}
}