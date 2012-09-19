package vms.db.dao;

import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.List;


import org.apache.commons.lang3.StringUtils;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.core.RowMapper;

import vms.db.dto.CongThucDTO;

public class CongThucDAO {

	private JdbcTemplate jdbcTemplate;


	public CongThucDAO(DaoFactory daoFactory) {
		this.jdbcTemplate=daoFactory.getJdbcTemplate();
		// TODO Auto-generated constructor stub
	}
	
	@SuppressWarnings("unchecked")
	
	public List<CongThucDTO> search(String _strSearch) {
		// TODO Auto-generated method stub
		return this.jdbcTemplate.query(
				"select * from congthuc where deleted = 0 and congthuc like '%"
						+ _strSearch + "%'", new RowMapper() {
					public Object mapRow(ResultSet rs, int rowNum)
							throws SQLException {
						
						return null;
					}
				});
	}

	@SuppressWarnings("unchecked")
	
	public List<CongThucDTO> get() {
		// TODO Auto-generated method stub
		return this.jdbcTemplate.query(
				"select * from congthuc where deleted = 0", new RowMapper() {
					public Object mapRow(ResultSet rs, int rowNum)
							throws SQLException {
						
						return CongThucDTO.mapObject(rs);
					}
				});
	}

	
	public CongThucDTO get(String id) {
		// TODO Auto-generated method stub
		@SuppressWarnings("unchecked")
		List<CongThucDTO> lst = this.jdbcTemplate.query(
				"select * from congthuc where deleted = 0 and id=" + id,
				new RowMapper() {
					public Object mapRow(ResultSet rs, int rowNum)
							throws SQLException {
						return CongThucDTO.mapObject(rs);
					}
				});
		if (lst.size() == 0)
			return null;
		return lst.get(0);
	}

	
	public boolean insert(CongThucDTO cat) {
		CongThucDTO congthuc=(CongThucDTO)cat;
		// TODO Auto-generated method stub
		try {
			Connection connection = this.jdbcTemplate.getDataSource()
					.getConnection();
			
			CallableStatement stmt = connection
					.prepareCall("{ call PROC_SAVE_congthuc(?,?,?,?) }");
			//stmt.registerOutParameter(1, OracleTypes.INTEGER);
			System.out.println("***BEGIN PROC_SAVE_congthuc***");
			stmt.setString(1, congthuc.getId());
			System.out.println(congthuc.getId());
			stmt.setString(2, congthuc.getTencongthuc());
			stmt.setString(3, congthuc.getChuoicongthuc());
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

	
	public boolean update(String id, CongThucDTO cat) {
		// TODO Auto-generated method stub
		CongThucDTO congthuc=(CongThucDTO)cat;
		// TODO Auto-generated method stub
		try {
			Connection connection = this.jdbcTemplate.getDataSource()
					.getConnection();
			
			CallableStatement stmt = connection
					.prepareCall("{ call PROC_SAVE_CONGTHUC(?,?,?,?,?,?,?) }");
			//stmt.registerOutParameter(1, OracleTypes.INTEGER);
			System.out.println("***BEGIN PROC_SAVE_congthuc***");
			stmt.setString(1, congthuc.getId());
			System.out.println(congthuc.getId());
			stmt.setString(2, congthuc.getTencongthuc());
			stmt.setString(3, congthuc.getChuoicongthuc());
			stmt.setString(4, congthuc.getUsercreate());
			stmt.setInt(5, congthuc.getStt());
			stmt.setInt(6, 0);//is deleted
			stmt.setString(7, congthuc.getMa());
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

	
	public boolean delete(String[] ids) {

		// TODO Auto-generated method stub
		String str = StringUtils.join(ids, ",");
		System.out.println(ids);
		return this.jdbcTemplate
				.update("update congthuc set DELETED = 1 where ID in (" + str
						+ ")") > 0;
	}

}