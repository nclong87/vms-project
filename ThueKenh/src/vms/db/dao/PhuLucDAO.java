package vms.db.dao;


import java.io.IOException;
import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashSet;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;
import java.util.Set;

import javax.sql.DataSource;
import oracle.jdbc.OracleTypes;
import oracle.sql.ARRAY;
import oracle.sql.ArrayDescriptor;

import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.core.RowMapper;
import org.xml.sax.SAXException;

import vms.db.dto.HopDongDTO;
import vms.db.dto.PhuLucDTO;
import vms.utils.DateUtils;
import vms.utils.VMSUtil;
import vms.utils.XMLUtil;

public class PhuLucDAO {
	private JdbcTemplate jdbcTemplate;
	private DataSource jdbcDatasource;
	public PhuLucDAO(DaoFactory daoFactory) {
		this.jdbcTemplate = daoFactory.getJdbcTemplate();
		this.jdbcDatasource = daoFactory.getJdbcDataSource();
	}
	
	private static final String SQL_FIND_PHULUC = "{ ? = call FIND_PHULUC(?,?,?,?,?,?,?,?,?,?,?,?,?) }";
	public List<Map<String,Object>> search(int iDisplayStart,int iDisplayLength,Map<String, String> conditions) throws SQLException, SAXException, IOException {
		Connection connection = jdbcDatasource.getConnection();
		CallableStatement stmt = connection.prepareCall(SQL_FIND_PHULUC);
		stmt.registerOutParameter(1, OracleTypes.CURSOR);
		stmt.setInt(2, iDisplayStart);
		stmt.setInt(3, iDisplayLength);
		stmt.setString(4, conditions.get("sohopdong"));
		stmt.setString(5, conditions.get("tenphuluc"));
		stmt.setString(6, conditions.get("loaiphuluc"));
		stmt.setString(7, conditions.get("trangthai"));
		stmt.setString(8, conditions.get("ngayky_from"));
		stmt.setString(9, conditions.get("ngayky_end"));
		stmt.setString(10, conditions.get("ngayhieuluc_from"));
		stmt.setString(11, conditions.get("ngayhieuluc_end"));
		stmt.setString(12, conditions.get("hopdong_id"));
		stmt.setString(13, conditions.get("ischeckAvailable"));
		stmt.setString(14, conditions.get("ngayDSC"));
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
			map.put("phulucbithaythe", XMLUtil.parseXMLString(rs.getString("PHULUCBITHAYTHE")));
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
	
	private static final String SQL_SAVE_PHULUC = "{ ? = call SAVE_PHULUC(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?) }";
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
		stmt.setString(14, String.valueOf(dto.getCuocdaunoi()));
		stmt.setString(15, String.valueOf(dto.getGiatritruocthue()));
		stmt.setString(16, String.valueOf(dto.getGiatrisauthue()));
		stmt.setString(17, dto.getSoluongkenh());
		stmt.setString(18, String.valueOf(dto.getThang()));
		stmt.setString(19, String.valueOf(dto.getNam()));
		stmt.execute();
		String rs = stmt.getString(1); 
		stmt.close();
		connection.close();
		return rs;
	}
	
	public void deleteByIds(String[] ids,String username) throws SQLException {
		Connection connection = this.jdbcDatasource.getConnection();
		System.out.println("***BEGIN PhuLucDAO.deleteByIds***");
		ArrayDescriptor descriptor = ArrayDescriptor.createDescriptor( "TABLE_VARCHAR", connection );
		ARRAY array =new ARRAY( descriptor, connection, ids );
		CallableStatement stmt = connection.prepareCall("call PROC_DELETE_PHULUC(?,?,?)");
		stmt.setArray(1, array);
		stmt.setString(2, username);
		stmt.setLong(3, System.currentTimeMillis());
		stmt.execute();
		stmt.close();
		connection.close();
		//this.jdbcTemplate.update("update PHULUC set DELETED = "+System.currentTimeMillis()+" where ID in ("+str+")");
	}
	
	private static final String SQL_DETAIL_PHULUC = "SELECT t.*,t0.SOHOPDONG,t0.LOAIHOPDONG,t0.DOITAC_ID,t2.TENDOITAC,FIND_PHULUC_BITHAYTHE(t.ID) as PHULUCBITHAYTHE FROM PHULUC t "+
		"left join HOPDONG t0 on t.HOPDONG_ID = t0.ID " +
		"left join DOITAC t2 on t0.DOITAC_ID = t2.ID WHERE t.ID=?";
	@SuppressWarnings("unchecked")
	public Map<String,Object> getDetail(String id) {
		List<Map<String,Object>> list =  this.jdbcTemplate.query(SQL_DETAIL_PHULUC ,new Object[] {id}, new RowMapper() {
			@Override
			public Object mapRow(ResultSet rs, int arg1) throws SQLException {
				Map<String,Object> map = VMSUtil.resultSetToMap(rs);
				map.put("ngayky", DateUtils.formatDate(rs.getDate("NGAYKY"), DateUtils.SDF_DDMMYYYY));
				map.put("ngayhieuluc", DateUtils.formatDate(rs.getDate("NGAYHIEULUC"), DateUtils.SDF_DDMMYYYY));
				map.put("ngayhethieuluc", DateUtils.formatDate(rs.getDate("NGAYHETHIEULUC"), DateUtils.SDF_DDMMYYYY));
				try {
					map.put("phulucbithaythe", XMLUtil.parseXMLString(rs.getString("PHULUCBITHAYTHE")));
				} catch (SAXException e) {
					e.printStackTrace();
				} catch (IOException e) {
					e.printStackTrace();
				} 
				return map;
			}
		});
		if(list.isEmpty()) return null;
		return list.get(0);
	}
	
	public void updatePhuLucThayThe(PhuLucDTO dtoPhulucThayThe,String[] arrPhulucBiThayThe,Date ngayHetHieuLuc,String username) throws SQLException {
		//this.jdbcTemplate.update("update PHULUC set PHULUCTHAYTHE_ID = ?, NGAYHETHIEULUC =? where ID in ("+StringUtils.join(arrPhulucBiThayThe, ",")+")", new Object[] {dtoPhulucThayThe.getId(), DateUtils.parseToSQLDate(ngayHetHieuLuc)});
		Connection connection = this.jdbcDatasource.getConnection();
		System.out.println("***BEGIN PhuLucDAO.updatePhuLucThayThe***");
		ArrayDescriptor descriptor = ArrayDescriptor.createDescriptor( "TABLE_VARCHAR", connection );
		ARRAY array =new ARRAY( descriptor, connection, arrPhulucBiThayThe );
		CallableStatement stmt = connection.prepareCall("call PROC_UPDATE_PLTHAYTHE(?,?,?,?,?)");
		stmt.setArray(1, array);
		stmt.setString(2, dtoPhulucThayThe.getId());
		stmt.setString(3, dtoPhulucThayThe.getTenphuluc());
		stmt.setDate(4, DateUtils.convertToSQLDate(ngayHetHieuLuc));
		stmt.setString(5, username);
		stmt.execute();
		stmt.close();
		connection.close();
	}
	
	private static final String SQL_FIND_PHULUC_HIEULUC = "{ ? = call FIND_PHULUC_HIEULUC(?,?) }";
	public Map<String,Object> findPhuLucCoHieuLuc(String tuyenkenh_id,java.sql.Date date) throws Exception {
		Connection connection = jdbcDatasource.getConnection();
		CallableStatement stmt = connection.prepareCall(SQL_FIND_PHULUC_HIEULUC);
		stmt.registerOutParameter(1, OracleTypes.CURSOR);
		stmt.setString(2, tuyenkenh_id);
		//stmt.setDate(3, DateUtils.convertToSQLDate(DateUtils.parseDate(sDate, "dd/MM/yyyy")));
		stmt.setDate(3, date);
		stmt.execute();
		ResultSet rs = (ResultSet) stmt.getObject(1);
		List<Map<String,Object>> result = new ArrayList<Map<String,Object>>();
		while(rs.next()) {
			Map<String,Object> map = PhuLucDTO.resultSetToMap(rs);
			result.add(map);
		}
		stmt.close();
		connection.close();
		if(result.size() > 1) throw new Exception("DUPLICATE_PHULUC");
		if(result.size() > 0) 
			return result.get(0);
		return null;
	}
	
	@SuppressWarnings("unchecked")
	public List<String> validateBeforeSavePhuLuc(PhuLucDTO phuLucDTO,String[] arrPhuLucThayThe,String sNgayHieuLuc,HopDongDTO dtoHopDong) {
		List<String> result = new ArrayList<String>();
		Set<String> setPhuLucThayThe = new HashSet<String>();
		for(int i=0;arrPhuLucThayThe != null && i<arrPhuLucThayThe.length;i++) {
			System.out.println("arrPhuLucThayThe[i] = "+arrPhuLucThayThe[i]);
			setPhuLucThayThe.add(arrPhuLucThayThe[i]);
		}
			
		List<Map<String,String>> list = this.jdbcTemplate.query("select t.*,t1.DOITAC_ID from CHITIETPHULUC_TUYENKENH t left join TUYENKENH t1 on t.TUYENKENH_ID = t1.ID where CHITIETPHULUC_ID = ?" ,new Object[] {phuLucDTO.getChitietphuluc_id()}, new RowMapper() {
			@Override
			public Object mapRow(ResultSet rs, int arg1) throws SQLException {
				Map<String,String> map = new LinkedHashMap<String, String>();
				map.put("tuyenkenh_id", rs.getString("TUYENKENH_ID"));
				map.put("doitac_id", rs.getString("DOITAC_ID"));
				return map;
			}
		});
		java.sql.Date date = DateUtils.convertToSQLDate(DateUtils.parseDate(sNgayHieuLuc, "dd/MM/yyyy"));
		for(int i=0; i< list.size();i++) {
			if(list.get(i).get("doitac_id").equals(dtoHopDong.getDoitac_id()) == false) {
				result.add("Tuyến kênh "+list.get(i).get("tuyenkenh_id")+" không thuộc đối tác đã chọn.");
			} else {
				try {
					Map<String, Object> mapPhuLuc = this.findPhuLucCoHieuLuc( list.get(i).get("tuyenkenh_id"), date);
					System.out.println("1");
					if(mapPhuLuc==null) continue;
					System.out.println("mapPhuLuc.get(id)="+mapPhuLuc.get("id"));
					System.out.println("phuLucDTO.getId()="+phuLucDTO.getId());
					if(setPhuLucThayThe.contains(mapPhuLuc.get("id")) == false && mapPhuLuc.get("id").equals(phuLucDTO.getId()) == false) {
						result.add("Tuyến kênh "+list.get(i).get("tuyenkenh_id")+" đang thuộc phụ lục "+mapPhuLuc.get("tenphuluc"));
					}
				} catch (Exception e) {
					e.printStackTrace();
					if(e.getMessage() == "DUPLICATE_PHULUC") {
						result.add("Tuyến kênh "+list.get(i).get("tuyenkenh_id")+" đang tồn tại trong nhiều hơn 1 phụ lục.");
					} else {
						result.add(e.getMessage());
					}
				}
			}
		}
		return result;
	}
	
	@SuppressWarnings("unchecked")
	public List<Map<String,Object>> findPhuLucThayThe(String phuluc_id) {
		return  this.jdbcTemplate.query("select * from PHULUC where DELETED = 0 and PHULUCTHAYTHE_ID = ?" ,new Object[] {phuluc_id}, new RowMapper() {
			@Override
			public Object mapRow(ResultSet rs, int arg1) throws SQLException {
				return PhuLucDTO.resultSetToMap(rs);
			}
		});
	}
	
	private static final String SQL_FIND_PHULUC_BY_HOPDONG_DOISOATCUOC = "{ ? = call FIND_PHULUC_BY_HD_DSC(?,?,?,?) }";
	public List<Map<String,Object>> searchByHopDongDoiSoatCuoc(int iDisplayStart,int iDisplayLength,Map<String, String> conditions) throws SQLException, SAXException, IOException {
		Connection connection = jdbcDatasource.getConnection();
		CallableStatement stmt = connection.prepareCall(SQL_FIND_PHULUC_BY_HOPDONG_DOISOATCUOC);
		stmt.registerOutParameter(1, OracleTypes.CURSOR);
		stmt.setInt(2, iDisplayStart);
		stmt.setInt(3, iDisplayLength);
		stmt.setString(4, conditions.get("doisoatcuoc_id"));
		stmt.setString(5, conditions.get("hopdong_id"));
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
			map.put("phulucbithaythe", XMLUtil.parseXMLString(rs.getString("PHULUCBITHAYTHE")));
			result.add(map);
			i++;
		}
		stmt.close();
		connection.close();
		return result;
	}
	
	private static final String SQL_FIND_TUYENKENHBYPHULUC = "select t1.*,LOAIGIAOTIEP from " +
			"CHITIETPHULUC_TUYENKENH t left join " +
			"TUYENKENH t1 on t.TUYENKENH_ID = t1.ID left join " +
			"LOAIGIAOTIEP t2 on t1.GIAOTIEP_ID = t2.ID where t.PHULUC_ID = ?";
	@SuppressWarnings("unchecked")
	public List<Map<String,Object>> findTuyenKenhByPhuLuc(String phuluc_id) {
		return  this.jdbcTemplate.query(SQL_FIND_TUYENKENHBYPHULUC,new Object[] {phuluc_id}, new RowMapper() {
			@Override
			public Object mapRow(ResultSet rs, int arg1) throws SQLException {
				return VMSUtil.resultSetToMap(rs);
			}
		});
	}
}