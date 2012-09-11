package vms.db.dao;

import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.List;


import org.apache.commons.lang3.StringUtils;
import org.springframework.jdbc.core.RowMapper;

import vms.db.dto.CatalogDTO;
import vms.db.dto.CongThucDTO;

public class CongThucDAO extends CatalogDAO {

	public CongThucDAO(DaoFactory daoFactory) {
		super(daoFactory);
		// TODO Auto-generated constructor stub
	}
	
	@SuppressWarnings("unchecked")
	@Override
	public List<CatalogDTO> search(String _strSearch) {
		// TODO Auto-generated method stub
		return this.jdbcTemplate.query(
				"select * from congthuc where deleted = 0 and congthuc like '%"
						+ _strSearch + "%'", new RowMapper() {
					public Object mapRow(ResultSet rs, int rowNum)
							throws SQLException {
						
						return new CongThucDTO(rs);
					}
				});
	}

	@SuppressWarnings("unchecked")
	@Override
	public List<CatalogDTO> get() {
		// TODO Auto-generated method stub
		return this.jdbcTemplate.query(
				"select * from congthuc where deleted = 0", new RowMapper() {
					public Object mapRow(ResultSet rs, int rowNum)
							throws SQLException {
						
						return new CongThucDTO(rs);
					}
				});
	}

	@Override
	public CatalogDTO get(long id) {
		// TODO Auto-generated method stub
		@SuppressWarnings("unchecked")
		List<CatalogDTO> lst = this.jdbcTemplate.query(
				"select * from congthuc where deleted = 0 and id=" + id,
				new RowMapper() {
					public Object mapRow(ResultSet rs, int rowNum)
							throws SQLException {
						return new CongThucDTO(rs);
					}
				});
		if (lst.size() == 0)
			return null;
		return lst.get(0);
	}

	@Override
	public boolean insert(CatalogDTO cat) {
		CongThucDTO congthuc=(CongThucDTO)cat;
		// TODO Auto-generated method stub
		try {
			Connection connection = this.jdbcTemplate.getDataSource()
					.getConnection();
			
			CallableStatement stmt = connection
					.prepareCall("{ call PROC_SAVE_congthuc(?,?,?,?) }");
			//stmt.registerOutParameter(1, OracleTypes.INTEGER);
			System.out.println("***BEGIN PROC_SAVE_congthuc***");
			stmt.setLong(1, congthuc.getId());
			System.out.println(congthuc.getId());
			stmt.setString(2, congthuc.getName());
			stmt.setInt(3, congthuc.getChoiCongThuc());
			stmt.setLong(4, 0);//is deleted
			System.out.println("***execute***");
			stmt.execute();
			stmt.close();
			connection.close();
			System.out.println("***END PROC_SAVE_congthuc***");
			return true;
		} catch (Exception e) {
			System.out.println(e.getMessage());
			return false;
		}
	}

	@Override
	public boolean update(long id, CatalogDTO cat) {
		// TODO Auto-generated method stub
		CongThucDTO congthuc=(CongThucDTO)cat;
		// TODO Auto-generated method stub
		try {
			Connection connection = this.jdbcTemplate.getDataSource()
					.getConnection();
			
			CallableStatement stmt = connection
					.prepareCall("{ call PROC_SAVE_CONGTHUC(?,?,?,?,?,?) }");
			//stmt.registerOutParameter(1, OracleTypes.INTEGER);
			System.out.println("***BEGIN PROC_SAVE_congthuc***");
			stmt.setLong(1, congthuc.getId());
			System.out.println(congthuc.getId());
			stmt.setString(2, congthuc.getName());
			stmt.setString(3, congthuc.getChoiCongThuc());
			stmt.setString(4, congthuc.getUserCreate());
			stmt.setInt(5, congthuc.getSTT());
			stmt.setInt(6, 0);//is deleted
			System.out.println("***execute***");
			stmt.execute();
			stmt.close();
			connection.close();
			System.out.println("***END PROC_SAVE_congthuc***");
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
				.update("update congthuc set DELETED = 1 where ID in (" + str
						+ ")") > 0;
	}

}