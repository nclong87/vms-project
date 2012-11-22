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

import com.opensymphony.xwork2.Action;

import vms.db.dto.TieuChuanDTO;
import vms.db.dto.TuyenKenh;
import vms.db.dto.TuyenKenhDeXuatDTO;
import vms.utils.DateUtils;
import vms.utils.VMSUtil;
import vms.web.models.FIND_TUYENKENHBANGIAO;

public class TuyenKenhBanGiaoDAO {
	private JdbcTemplate jdbcTemplate;
	private DataSource jdbcDatasource;
	public TuyenKenhBanGiaoDAO(DaoFactory daoFactory) {
		this.jdbcTemplate = daoFactory.getJdbcTemplate();
		this.jdbcDatasource = daoFactory.getJdbcDataSource();
	}
	
	private static final String SQL_FIND_TUYENKENHBANGIAO = "{ ? = call FIND_TUYENKENHBANGIAO(?,?,?,?,?,?,?,?,?,?,?,?,?,?) }";
	public List<Map<String,Object>> search(int iDisplayStart,int iDisplayLength,Map<String, String> conditions) throws SQLException {
		System.out.println("FIND_TUYENKENHBANGIAO tt="+conditions.get("iTrangThai"));
		Connection connection = jdbcDatasource.getConnection();
		CallableStatement stmt = connection.prepareCall(SQL_FIND_TUYENKENHBANGIAO);
		stmt.registerOutParameter(1, OracleTypes.CURSOR);
		stmt.setInt(2, iDisplayStart);
		stmt.setInt(3, iDisplayLength);
		stmt.setString(4, conditions.get("makenh"));
		stmt.setString(5, conditions.get("loaigiaotiep"));
		stmt.setString(6, conditions.get("madiemdau"));
		stmt.setString(7, conditions.get("madiemcuoi"));
		stmt.setString(8, conditions.get("duan"));
		stmt.setString(9, conditions.get("ngaydenghibangiao"));
		stmt.setString(10, conditions.get("ngayhenbangiao"));
		stmt.setString(11, conditions.get("dexuat_id"));
		stmt.setString(12, conditions.get("khuvuc_id"));
		stmt.setString(13, conditions.get("phongban_id"));
		stmt.setString(14, conditions.get("isAllow"));
		String strTemp=conditions.get("iTrangThai");
		stmt.setString(15,strTemp==null?"0":strTemp);
		//System.out.println(SQL_FIND_TUYENKENHBANGIAO);
		stmt.execute();
		ResultSet rs = (ResultSet) stmt.getObject(1);
		List<Map<String,Object>> result = new ArrayList<Map<String,Object>>();
		int i = 1;
		while(rs.next()) {
			Map<String,Object> map = VMSUtil.resultSetToMap(rs);
			map.put("stt", i);
			result.add(map);
			i++;
		}
		stmt.close();
		connection.close();
		return result;
	}
	
	@SuppressWarnings("unchecked")
	public List<TieuChuanDTO> getTieuChuanDatDuoc(String id){
		return this.jdbcTemplate.query(
				"select tc.*  " +
				"from tuyenkenh_tieuchuan tt,tieuchuan tc " +
				"where tt.tieuchuan_id=tc.id  and tuyenkenhdexuat_id="+id+" and tt.deleted=0 and tc.deleted=0", new RowMapper() {
					
					public Object mapRow(ResultSet rs, int rowNum)
							throws SQLException {
						return TieuChuanDTO.mapObject(rs);
					}
				});
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
	/*public String save(TuyenKenh tuyenKenh,TuyenKenhDeXuatDTO tuyenKenhDeXuatDTO,int soluong_old) throws Exception {
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
	}*/
	
	public void deleteByIds(String[] ids) {
		for(int i=0;i<ids.length;i++) {
			String id = ids[i];
			TuyenKenhDeXuatDTO dto = this.findById(id);
			if(dto!=null) {
				int soluong = dto.getSoluong();
				this.jdbcTemplate.update("update TUYENKENHDEXUAT set DELETED = "+System.currentTimeMillis()+" where ID = ?",new Object[]{id});
				this.jdbcTemplate.update("update TUYENKENH set TRANGTHAI = TRANGTHAI_BAK,SOLUONG = SOLUONG - ? where ID = ?",new Object[]{soluong,dto.getTuyenkenh_id()});
			}
		}
	}
	public void updateDexuatByIds(String[] ids,String dexuat_id) {
		String str = StringUtils.join(ids, ",");
		this.jdbcTemplate.update("update TUYENKENHDEXUAT set DEXUAT_ID = ? where ID in ("+str+")", new Object[] {dexuat_id});
	}
	// static final String SQL_SAVE_TUYENKENHBANGIAO = "{ ? = call CAPNHATTIENDO(?,?,?) }";
	private static final String SQL_PROC_UPDATE_TIEN_DO = "{ call PROC_UPDATE_TIEN_DO(?,?,?,?) }";
	public void capNhatTienDo(String tuyenkenh_tieuchuan_id, String[] tieuchuan_id,String username) throws Exception  {
		Connection connection = this.jdbcDatasource.getConnection();
		System.out.println("***BEGIN capNhatTienDo***");
		ArrayDescriptor descriptor = ArrayDescriptor.createDescriptor( "TABLE_VARCHAR", connection );
		ARRAY array =new ARRAY( descriptor, connection, tieuchuan_id );
		CallableStatement stmt = connection.prepareCall(SQL_PROC_UPDATE_TIEN_DO);
		stmt.setString(1, tuyenkenh_tieuchuan_id);
		stmt.setArray(2, array);
		stmt.setString(3, username);
		stmt.setString(4, DateUtils.getCurrentDateSQL());
		stmt.execute();
		stmt.close();
		connection.close();
	}

	public void xoaTienDo(String id) {
		// TODO Auto-generated method stub
		this.jdbcTemplate.update("update TUYENKENH_TIEUCHUAN set DELETED = "+System.currentTimeMillis()+" where TUYENKENHDEXUAT_ID="+id);
	}
}