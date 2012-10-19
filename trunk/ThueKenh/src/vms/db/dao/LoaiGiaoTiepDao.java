package vms.db.dao;

import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.List;


import org.apache.commons.lang3.StringUtils;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.core.RowMapper;

import vms.db.dto.LoaiGiaoTiepDTO;
import vms.db.dto.LoaiGiaoTiep;

public class LoaiGiaoTiepDao {

	private JdbcTemplate jdbcTemplate;


	public LoaiGiaoTiepDao(DaoFactory daoFactory) {
		this.jdbcTemplate=daoFactory.getJdbcTemplate();
		// TODO Auto-generated constructor stub
	}
	
	@SuppressWarnings("unchecked")
	
	public List<LoaiGiaoTiepDTO> search(String _strSearch) {
		// TODO Auto-generated method stub
		return this.jdbcTemplate.query(
				"select * from loaigiaotiep where deleted = 0 and LOAIGIAOTIEP like '%"
						+ _strSearch + "%'", new RowMapper() {
					public Object mapRow(ResultSet rs, int rowNum)
							throws SQLException {
						
						return LoaiGiaoTiepDTO.mapObject(rs);
					}
				});
	}
	
	@SuppressWarnings("unchecked")
	public List<LoaiGiaoTiep> getAll() {
		// TODO Auto-generated method stub
		return this.jdbcTemplate.query(
				"select * from loaigiaotiep where deleted = 0", new RowMapper() {
					public Object mapRow(ResultSet rs, int rowNum)
							throws SQLException {
						return LoaiGiaoTiep.mapObject(rs);
					}
				});
	}
	
	@SuppressWarnings("unchecked")
	
	public List<LoaiGiaoTiepDTO> get() {
		// TODO Auto-generated method stub
		return this.jdbcTemplate.query(
				"select * from loaigiaotiep where deleted = 0", new RowMapper() {
					public Object mapRow(ResultSet rs, int rowNum)
							throws SQLException {
						return LoaiGiaoTiepDTO.mapObject(rs);
					}
				});
	}

	
	public LoaiGiaoTiepDTO get(String id) {
		// TODO Auto-generated method stub
		@SuppressWarnings("unchecked")
		List<LoaiGiaoTiepDTO> lst = this.jdbcTemplate.query(
				"select * from loaigiaotiep where deleted = 0 and id=" + id,
				new RowMapper() {
					public Object mapRow(ResultSet rs, int rowNum)
							throws SQLException {
						return LoaiGiaoTiepDTO.mapObject(rs);
					}
				});
		if (lst.size() == 0)
			return null;
		return lst.get(0);
	}

	
	public boolean insert(LoaiGiaoTiepDTO cat) {
		LoaiGiaoTiepDTO loaigiaotiep=(LoaiGiaoTiepDTO)cat;
		// TODO Auto-generated method stub
		try {
			Connection connection = this.jdbcTemplate.getDataSource()
					.getConnection();
			
			CallableStatement stmt = connection
					.prepareCall("{ call PROC_SAVE_LOAIGIAOTIEP(?,?,?,?,?,?) }");
			//stmt.registerOutParameter(1, OracleTypes.INTEGER);
			System.out.println("***BEGIN PROC_SAVE_LOAIGIAOTIEP***"+loaigiaotiep.getCuoccong());
			stmt.setString(1, loaigiaotiep.getId());
			System.out.println(loaigiaotiep.getId());
			stmt.setString(2, loaigiaotiep.getLoaigiaotiep());
			stmt.setLong(3, loaigiaotiep.getCuoccong());
			stmt.setLong(4, 0);//is deleted
			stmt.setString(5, loaigiaotiep.getMa());
			stmt.setInt(6, loaigiaotiep.getStt());
			System.out.println("***execute***");
			stmt.execute();
			stmt.close();
			connection.close();
			System.out.println("***END PROC_SAVE_LOAIGIAOTIEP***");
			return true;
		} catch (Exception e) {
			System.out.println(e.getMessage());
			return false;
		}
	}

	
	public boolean update(String id, LoaiGiaoTiepDTO cat) {
		// TODO Auto-generated method stub
		LoaiGiaoTiepDTO loaigiaotiep=(LoaiGiaoTiepDTO)cat;
		// TODO Auto-generated method stub
		try {
			Connection connection = this.jdbcTemplate.getDataSource()
					.getConnection();
			
			CallableStatement stmt = connection
					.prepareCall("{ call PROC_SAVE_LOAIGIAOTIEP(?,?,?,?,?,?) }");
			//stmt.registerOutParameter(1, OracleTypes.INTEGER);
			System.out.println("***BEGIN PROC_SAVE_LOAIGIAOTIEP***"+loaigiaotiep.getCuoccong());
			stmt.setString(1, loaigiaotiep.getId());
			System.out.println(loaigiaotiep.getId());
			stmt.setString(2, loaigiaotiep.getLoaigiaotiep());
			stmt.setLong(3, loaigiaotiep.getCuoccong());
			stmt.setLong(4, 0);//is deleted
			stmt.setString(5, loaigiaotiep.getMa());
			stmt.setInt(6, loaigiaotiep.getStt());
			System.out.println("***execute***");
			stmt.execute();
			stmt.close();
			connection.close();
			System.out.println("***END PROC_SAVE_LOAIGIAOTIEP***");
			return true;
		} catch (Exception e) {
			e.printStackTrace();
			return false;
		}
	}

	
	public boolean delete(String[] ids) {

		// TODO Auto-generated method stub
		String str = StringUtils.join(ids, ",");
		System.out.println(ids);
		return this.jdbcTemplate
				.update("update loaigiaotiep set DELETED = "+System.currentTimeMillis()+" where ID in (" + str
						+ ")") > 0;
	}

}