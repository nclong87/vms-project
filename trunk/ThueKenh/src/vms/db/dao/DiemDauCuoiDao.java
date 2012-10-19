package vms.db.dao;

import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.List;


import org.apache.commons.lang3.StringUtils;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.core.RowMapper;

import vms.db.dto.DiemDauCuoiDTO;

public class DiemDauCuoiDao  {
	private JdbcTemplate jdbcTemplate;
	public DiemDauCuoiDao(DaoFactory daoFactory) {
		this.jdbcTemplate=daoFactory.getJdbcTemplate();
		// TODO Auto-generated constructor stub
	}

	@SuppressWarnings("unchecked")
	public List<DiemDauCuoiDTO> getAll() {
		return this.jdbcTemplate.query(
				"select * from DiemDauCuoi where deleted = 0 order by stt", new RowMapper() {
					public Object mapRow(ResultSet rs, int rowNum)
							throws SQLException {
						return DiemDauCuoiDTO.mapObject(rs);
					}
				});
	}

	@SuppressWarnings("unchecked")
	public List<DiemDauCuoiDTO> search(String _strSearch) {
		// TODO Auto-generated method stub
		return this.jdbcTemplate.query(
				"select * from DiemDauCuoi where deleted = 0 and tenDiemDauCuoi like '%"
						+ _strSearch + "%'", new RowMapper() {
					public Object mapRow(ResultSet rs, int rowNum)
							throws SQLException {
						return DiemDauCuoiDTO.mapObject(rs);
					}
				});
	}

	@SuppressWarnings("unchecked")
	
	public List<DiemDauCuoiDTO> get() {
		// TODO Auto-generated method stub
		return this.jdbcTemplate.query(
				"select * from DiemDauCuoi where deleted = 0  order by stt", new RowMapper() {
					public Object mapRow(ResultSet rs, int rowNum)
							throws SQLException {
						return DiemDauCuoiDTO.mapObject(rs);
					}
				});
	}

	public DiemDauCuoiDTO get(String id) {
		// TODO Auto-generated method stub
		@SuppressWarnings("unchecked")
		List<DiemDauCuoiDTO> lst = this.jdbcTemplate.query(
				"select * from DiemDauCuoi where deleted = 0 and id=" + id,
				new RowMapper() {
					public Object mapRow(ResultSet rs, int rowNum)
							throws SQLException {
						return DiemDauCuoiDTO.mapObject(rs);
					}
				});
		if (lst.size() == 0)
			return null;
		return lst.get(0);
	}

	
	public boolean insert(DiemDauCuoiDTO cat) {
		// TODO Auto-generated method stub
		try {
			Connection connection = this.jdbcTemplate.getDataSource()
					.getConnection();
			
			CallableStatement stmt = connection
					.prepareCall("{ call PROC_SAVE_DiemDauCuoi(?,?,?,?,?) }");
			//stmt.registerOutParameter(1, OracleTypes.INTEGER);
			System.out.println("***BEGIN PROC_SAVE_DiemDauCuoi***");
			System.out.println(cat.getId());
			stmt.setString(1, cat.getId());
			stmt.setString(2, cat.getTendiemdaucuoi());
			stmt.setInt(3, cat.getStt());
			stmt.setLong(4, 0);
			stmt.setString(5, cat.getMa());
			System.out.println("***execute***");
			stmt.execute();
			stmt.close();
			connection.close();
			System.out.println("***END PROC_SAVE_DiemDauCuoi***");
			return true;
		} catch (Exception e) {
			e.printStackTrace();
			return false;
		}
	}

	
	public boolean update(String id, DiemDauCuoiDTO cat) {
		// TODO Auto-generated method stub
		DiemDauCuoiDTO up = (DiemDauCuoiDTO) cat;
		String sql = "update DiemDauCuoi set ma='"+cat.getMa()+"' ,stt="+up.getStt()+", tenDiemDauCuoi='" + up.getTendiemdaucuoi()+ "' where id=" + up.getId();
		System.out.println(sql);
		return this.jdbcTemplate.update(sql) > 0;
	}

	
	public boolean delete(String[] ids) {

		// TODO Auto-generated method stub
		String str = StringUtils.join(ids, ",");
		System.out.println(ids);
		return this.jdbcTemplate
				.update("update DiemDauCuoi set DELETED = "+System.currentTimeMillis()+" where ID in (" + str
						+ ")") > 0;
	}

}