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
import vms.db.dto.TuyenKenhDeXuatDTO;
import vms.web.models.FIND_TUYENKENHDEXUAT;

public class TuyenKenhDeXuatDAO {
	private JdbcTemplate jdbcTemplate;
	private DataSource jdbcDatasource;
	public TuyenKenhDeXuatDAO(DaoFactory daoFactory) {
		this.jdbcTemplate = daoFactory.getJdbcTemplate();
		this.jdbcDatasource = daoFactory.getJdbcDataSource();
	}
	
	private static final String SQL_FIND_TUYENKENHDEXUAT = "{ ? = call FIND_TUYENKENHDEXUAT(?,?,?,?,?,?,?,?,?,?,?,?) }";
	public List<FIND_TUYENKENHDEXUAT> search(int iDisplayStart,int iDisplayLength,Map<String, String> conditions) throws SQLException {
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
		stmt.setString(9, conditions.get("khuvuc"));
		stmt.setString(10, conditions.get("phongban"));
		stmt.setString(11, conditions.get("ngaydenghibangiao"));
		stmt.setString(12, conditions.get("ngayhenbangiao"));
		stmt.setString(13, conditions.get("trangthai"));
		stmt.execute();
		ResultSet rs = (ResultSet) stmt.getObject(1);
		List<FIND_TUYENKENHDEXUAT> result = new ArrayList<FIND_TUYENKENHDEXUAT>();
		while(rs.next()) {
			result.add(FIND_TUYENKENHDEXUAT.mapObject(rs));
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
		stmt.setString(9, tuyenKenh.getKhuvuc_id());
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
	
	public void deleteByIds(String[] ids) {
		for(int i=0;i<ids.length;i++) {
			String id = ids[i];
			TuyenKenhDeXuatDTO dto = this.findById(id);
			if(dto!=null) {
				int soluong = dto.getSoluong();
				this.jdbcTemplate.update("update TUYENKENHDEXUAT set DELETED = 1 where ID = ?",new Object[]{id});
				this.jdbcTemplate.update("update TUYENKENH set TRANGTHAI = TRANGTHAI_BAK,SOLUONG = SOLUONG - ? where ID = ?",new Object[]{soluong,dto.getTuyenkenh_id()});
			}
		}
	}
}