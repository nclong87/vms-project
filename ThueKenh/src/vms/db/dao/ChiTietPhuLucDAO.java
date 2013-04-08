package vms.db.dao;


import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;
import javax.sql.DataSource;
import oracle.jdbc.OracleTypes;

import org.apache.commons.lang3.StringUtils;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.core.RowMapper;

import vms.db.dto.ChiTietPhuLucDTO;
import vms.db.dto.ChiTietPhuLucTuyenKenhDTO;
import vms.utils.Constances;
import vms.utils.VMSUtil;

public class ChiTietPhuLucDAO {
	private JdbcTemplate jdbcTemplate;
	private DataSource jdbcDatasource;
	public ChiTietPhuLucDAO(DaoFactory daoFactory) {
		this.jdbcTemplate = daoFactory.getJdbcTemplate();
		this.jdbcDatasource = daoFactory.getJdbcDataSource();
	}
	
	private static final String SQL_PROC_SAVE_CTPL_TUYENKENH_TMP = "{ call PROC_SAVE_CTPL_TUYENKENH_TMP(?,?,?,?,?,?,?,?) }";
	public Map<String,Object> saveChiTietPhuLucTuyenKenh(List<ChiTietPhuLucTuyenKenhDTO> chiTietPhuLucTuyenKenhDTOs,Map<String,String> mapCongThuc) throws Exception {
		Map<String,Object> result = new LinkedHashMap<String, Object>();
		this.jdbcTemplate.execute("truncate table CHITIETPHULUC_TUYENKENH_TMP drop storage");
		System.out.println("***BEGIN saveChiTietPhuLucTuyenKenh***");
		Connection connection = this.jdbcDatasource.getConnection();
		CallableStatement stmt = connection.prepareCall(SQL_PROC_SAVE_CTPL_TUYENKENH_TMP);
		long cuocDauNoi = 0;
		long giaTri = 0;
		Map<String,Integer> mapSoKenh = new LinkedHashMap<String, Integer>();
		List<String> sLoaiGiaoTiep = new ArrayList<String>();
		for(int i = 0; i<chiTietPhuLucTuyenKenhDTOs.size();i++) {
			ChiTietPhuLucTuyenKenhDTO dto = chiTietPhuLucTuyenKenhDTOs.get(i);
			if(mapSoKenh.containsKey(dto.getLoaigiaotiep())) {
				mapSoKenh.put(dto.getLoaigiaotiep(), mapSoKenh.get(dto.getLoaigiaotiep()) + dto.getSoluong());
			} else {
				mapSoKenh.put(dto.getLoaigiaotiep(), dto.getSoluong());
				sLoaiGiaoTiep.add(dto.getLoaigiaotiep());
			}
			cuocDauNoi += dto.getCuocdaunoi();
			//Tinh don gia thuc sau khi giam gia
			Long dongia = dto.getDongia() - (dto.getDongia() * dto.getGiamgia()/100);
			String[][] replacements = {
					{Constances.DONGIA, String.valueOf(dongia)}, 
	                {Constances.SOLUONG, String.valueOf(dto.getSoluong())},
	                {Constances.CUOCONG, String.valueOf(dto.getCuoccong())}
					};
			String exp = VMSUtil.replacements(mapCongThuc.get(dto.getCongthuc_id()), replacements);
			Long thanhTien = (long)VMSUtil.calculate(exp);
			System.out.println("Tuyenkenh_id ="+dto.getTuyenkenh_id());
			stmt.setString(1,dto.getTuyenkenh_id());
			stmt.setString(2,dto.getCongthuc_id());
			stmt.setInt(3,dto.getSoluong());
			stmt.setLong(4,dto.getCuoccong());
			stmt.setLong(5,dto.getCuocdaunoi());
			stmt.setLong(6,dto.getDongia());
			stmt.setInt(7,dto.getGiamgia());
			stmt.setLong(8,thanhTien);
			stmt.execute();
			giaTri += thanhTien;
		}
		stmt.close();
		connection.close();
		System.out.println("***END saveChiTietPhuLucTuyenKenh***");
		String[] soLuongKenh = new String[sLoaiGiaoTiep.size()];
		for(int i=0;i<sLoaiGiaoTiep.size();i++) {
			soLuongKenh[i] = String.valueOf(mapSoKenh.get(sLoaiGiaoTiep.get(i)))+" "+sLoaiGiaoTiep.get(i);
		}
		result.put("cuocDauNoi", cuocDauNoi);
		result.put("giaTriTruocThue", giaTri);
		result.put("giaTriSauThue", giaTri + giaTri*10/100);
		result.put("soLuongKenh", StringUtils.join(soLuongKenh, ";"));
		return result;
	}
	
	private static final String SQL_SAVE_CHITIETPHULUC = "{ ? = call SAVE_CHITIETPHULUC(?,?,?,?,?,?,?,?) }";
	public String saveChiTietPhuLuc(ChiTietPhuLucDTO dto) throws Exception {
		Connection connection = jdbcDatasource.getConnection();
		CallableStatement stmt = connection.prepareCall(SQL_SAVE_CHITIETPHULUC);
		stmt.registerOutParameter(1, OracleTypes.VARCHAR);
		stmt.setString(2, dto.getId());
		stmt.setString(3, dto.getTenchitietphuluc());
		stmt.setString(4, String.valueOf(dto.getCuocdaunoi()));
		stmt.setString(5, String.valueOf(dto.getGiatritruocthue()));
		stmt.setString(6, String.valueOf(dto.getGiatrisauthue()));
		stmt.setString(7, dto.getUsercreate());
		stmt.setString(8, dto.getTimecreate());
		stmt.setString(9, dto.getSoluongkenh());
		stmt.execute();
		String result = stmt.getString(1);
		stmt.close();
		connection.close();
		return result;
	}
	
	@SuppressWarnings("unchecked")
	public ChiTietPhuLucDTO findByKey(String tenchitietphuluc) {
		List<ChiTietPhuLucDTO> list =  this.jdbcTemplate.query("select * from CHITIETPHULUC where DELETED = 0 and TENCHITIETPHULUC = ?" ,new Object[] {tenchitietphuluc}, new RowMapper() {
			@Override
			public Object mapRow(ResultSet rs, int arg1) throws SQLException {
				return ChiTietPhuLucDTO.mapObject(rs);
			}
		});
		if(list.isEmpty()) return null;
		return list.get(0);
	}
	
	private static final String SQL_FIND_CHITIETPHULUC = "{ ? = call FIND_CHITIETPHULUC(?,?,?) }";
	public List<Map<String,Object>> search(int iDisplayStart,int iDisplayLength,Map<String, String> conditions) throws SQLException {
		Connection connection = jdbcDatasource.getConnection();
		CallableStatement stmt = connection.prepareCall(SQL_FIND_CHITIETPHULUC);
		stmt.registerOutParameter(1, OracleTypes.CURSOR);
		stmt.setInt(2, iDisplayStart);
		stmt.setInt(3, iDisplayLength);
		stmt.setString(4, conditions.get("tenchitietphuluc"));
		stmt.execute();
		ResultSet rs = (ResultSet) stmt.getObject(1);
		List<Map<String,Object>> result = new ArrayList<Map<String,Object>>();
		int i = 1;
		while(rs.next()) {
			Map<String,Object> map = VMSUtil.resultSetToMap(rs);
			map.put("stt", i);
			//map.put("isblock",true);
			result.add(map);
			i++;
		}
		stmt.close();
		connection.close();
		return result;
	}
	
	private static final String SQL_FIND_TUYENKENHBYCHITIETPHULUC = "select t1.*,LOAIGIAOTIEP,TENDOITAC from " +
			"CHITIETPHULUC_TUYENKENH t left join " +
			"TUYENKENH t1 on t.TUYENKENH_ID = t1.ID left join " +
			"LOAIGIAOTIEP t2 on t1.GIAOTIEP_ID = t2.ID left join " +
			"DOITAC t3 on t1.DOITAC_ID = t3.ID where t.CHITIETPHULUC_ID = ?";
	@SuppressWarnings("unchecked")
	public List<Map<String,Object>> findTuyenKenhByChiTietPhuLuc(String chitietphuluc_id) {
		return  this.jdbcTemplate.query(SQL_FIND_TUYENKENHBYCHITIETPHULUC,new Object[] {chitietphuluc_id}, new RowMapper() {
			@Override
			public Object mapRow(ResultSet rs, int arg1) throws SQLException {
				return VMSUtil.resultSetToMap(rs);
			}
		});
	}
	
	public void deleteByIds(String[] ids) {
		String str = StringUtils.join(ids, ",");
		this.jdbcTemplate.update("update CHITIETPHULUC set DELETED = 1 where ID in ("+str+")");
	}
	
	private static final String SQL_FIND_CHITIETPHULUCBYID = "{ ? = call FIND_CHITIETPHULUCBYID(?,?,?) }";
	public List<Map<String,Object>> FindChiTietPhuLucById(int iDisplayStart,int iDisplayLength,String chitietphuluc_id) throws SQLException {
		Connection connection = jdbcDatasource.getConnection();
		CallableStatement stmt = connection.prepareCall(SQL_FIND_CHITIETPHULUCBYID);
		stmt.registerOutParameter(1, OracleTypes.CURSOR);
		stmt.setInt(2, iDisplayStart);
		stmt.setInt(3, iDisplayLength);
		stmt.setString(4, chitietphuluc_id);
		stmt.execute();
		ResultSet rs = (ResultSet) stmt.getObject(1);
		List<Map<String,Object>> result = new ArrayList<Map<String,Object>>();
		while(rs.next()) {
			Map<String,Object> map = VMSUtil.resultSetToMap(rs);
			result.add(map);
		}
		stmt.close();
		connection.close();
		return result;
	}
	
	public ChiTietPhuLucDTO findById(String id) {
		System.out.println("Begin findbyId - Id:"+id);
		return (ChiTietPhuLucDTO) this.jdbcTemplate.queryForObject("select * from CHITIETPHULUC where ID = ? and DELETED = 0" ,new Object[] {id}, new RowMapper() {
			@Override
			public Object mapRow(ResultSet rs, int arg1) throws SQLException {
				return ChiTietPhuLucDTO.mapObject(rs);
			}
		});
	}
}