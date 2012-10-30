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
import oracle.sql.ARRAY;
import oracle.sql.ArrayDescriptor;

import org.apache.commons.lang3.StringUtils;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.core.RowMapper;

import vms.db.dto.ChiTietPhuLucDTO;
import vms.db.dto.ChiTietPhuLucTuyenKenhDTO;
import vms.db.dto.DeXuatDTO;
import vms.db.dto.PhuLucDTO;
import vms.db.dto.TuyenKenh;
import vms.utils.Constances;
import vms.utils.DateUtils;
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
			System.out.println("thanhTien ="+thanhTien);
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
			soLuongKenh[i] = String.valueOf(mapSoKenh.get(sLoaiGiaoTiep.get(i)))+sLoaiGiaoTiep.get(i);
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
}