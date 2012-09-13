package vms.db.dao;

import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.List;


import org.apache.commons.lang3.StringUtils;
import org.springframework.jdbc.core.RowMapper;

import vms.db.dto.CatalogDTO;
import vms.db.dto.LoaiGiaoTiep;
import vms.db.dto.LoaiGiaoTiepDTO;

public class LoaiGiaoTiepDao extends CatalogDAO {

	public LoaiGiaoTiepDao(DaoFactory daoFactory) {
		super(daoFactory);
		// TODO Auto-generated constructor stub
	}
	
	@SuppressWarnings("unchecked")
	@Override
	public List<CatalogDTO> search(String _strSearch) {
		// TODO Auto-generated method stub
		return this.jdbcTemplate.query(
				"select * from loaigiaotiep where deleted = 0 and LOAIGIAOTIEP like '%"
						+ _strSearch + "%'", new RowMapper() {
					public Object mapRow(ResultSet rs, int rowNum)
							throws SQLException {
						LoaiGiaoTiepDTO cat = new LoaiGiaoTiepDTO();
						cat.setId(rs.getString("ID"));
						cat.setName(rs.getString("LOAIGIAOTIEP"));
						cat.setCuocCong(rs.getInt("CUOCCONG"));
						cat.setDeleted(rs.getInt("DELETED"));
						return cat;
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
	@Override
	public List<CatalogDTO> get() {
		// TODO Auto-generated method stub
		return this.jdbcTemplate.query(
				"select * from loaigiaotiep where deleted = 0", new RowMapper() {
					public Object mapRow(ResultSet rs, int rowNum)
							throws SQLException {
						LoaiGiaoTiepDTO cat = new LoaiGiaoTiepDTO();
						cat.setId(rs.getString("ID"));
						cat.setName(rs.getString("LOAIGIAOTIEP"));
						cat.setCuocCong(rs.getInt("CUOCCONG"));
						cat.setDeleted(rs.getInt("DELETED"));
						return cat;
					}
				});
	}

	@Override
	public CatalogDTO get(String id) {
		// TODO Auto-generated method stub
		@SuppressWarnings("unchecked")
		List<CatalogDTO> lst = this.jdbcTemplate.query(
				"select * from loaigiaotiep where deleted = 0 and id=" + id,
				new RowMapper() {
					public Object mapRow(ResultSet rs, int rowNum)
							throws SQLException {
						LoaiGiaoTiepDTO cat = new LoaiGiaoTiepDTO();
						cat.setId(rs.getString("ID"));
						cat.setName(rs.getString("LOAIGIAOTIEP"));
						cat.setCuocCong(rs.getInt("CUOCCONG"));
						cat.setDeleted(rs.getInt("DELETED"));
						return cat;
					}
				});
		if (lst.size() == 0)
			return null;
		return lst.get(0);
	}

	@Override
	public boolean insert(CatalogDTO cat) {
		LoaiGiaoTiepDTO loaigiaotiep=(LoaiGiaoTiepDTO)cat;
		// TODO Auto-generated method stub
		try {
			Connection connection = this.jdbcTemplate.getDataSource()
					.getConnection();
			
			CallableStatement stmt = connection
					.prepareCall("{ call PROC_SAVE_LOAIGIAOTIEP(?,?,?,?) }");
			//stmt.registerOutParameter(1, OracleTypes.INTEGER);
			System.out.println("***BEGIN PROC_SAVE_LOAIGIAOTIEP***"+loaigiaotiep.getCuocCong());
			stmt.setString(1, loaigiaotiep.getId());
			System.out.println(loaigiaotiep.getId());
			stmt.setString(2, loaigiaotiep.getName());
			stmt.setInt(3, loaigiaotiep.getCuocCong());
			stmt.setLong(4, 0);//is deleted
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

	@Override
	public boolean update(String id, CatalogDTO cat) {
		// TODO Auto-generated method stub
		LoaiGiaoTiepDTO loaigiaotiep=(LoaiGiaoTiepDTO)cat;
		// TODO Auto-generated method stub
		try {
			Connection connection = this.jdbcTemplate.getDataSource()
					.getConnection();
			
			CallableStatement stmt = connection
					.prepareCall("{ call PROC_SAVE_LOAIGIAOTIEP(?,?,?,?) }");
			//stmt.registerOutParameter(1, OracleTypes.INTEGER);
			System.out.println("***BEGIN PROC_SAVE_LOAIGIAOTIEP***");
			stmt.setString(1, loaigiaotiep.getId());
			System.out.println(loaigiaotiep.getId());
			stmt.setString(2, loaigiaotiep.getName());
			stmt.setInt(3, loaigiaotiep.getCuocCong());
			stmt.setLong(4, 0);//is deleted
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

	@Override
	public boolean delete(String[] ids) {

		// TODO Auto-generated method stub
		String str = StringUtils.join(ids, ",");
		System.out.println(ids);
		return this.jdbcTemplate
				.update("update loaigiaotiep set DELETED = 1 where ID in (" + str
						+ ")") > 0;
	}

}