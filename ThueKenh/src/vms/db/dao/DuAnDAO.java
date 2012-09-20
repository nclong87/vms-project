package vms.db.dao;

import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.List;

import org.apache.commons.lang3.StringUtils;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.core.RowMapper;

import vms.db.dto.DuAnDTO;

public class DuAnDAO {

	private JdbcTemplate jdbcTemplate;

	public DuAnDAO(DaoFactory daoFactory) {
		this.jdbcTemplate=daoFactory.getJdbcTemplate();
		// TODO Auto-generated constructor stub
	}

	@SuppressWarnings("unchecked")
	public List<DuAnDTO> findAll() {
		// TODO Auto-generated method stub
		return this.jdbcTemplate.query(
				"select * from duan where deleted = 0", new RowMapper() {
					public Object mapRow(ResultSet rs, int rowNum)
							throws SQLException {
						return DuAnDTO.mapObject(rs);
					}
				});
	}
	
	@SuppressWarnings("unchecked")
	
	public List<DuAnDTO> get() {
		// TODO Auto-generated method stub
		return this.jdbcTemplate.query(
				"select * from duan where deleted = 0", new RowMapper() {
					public Object mapRow(ResultSet rs, int rowNum)
							throws SQLException {
						return DuAnDTO.mapObject(rs);
					}
				});
	}

	@SuppressWarnings("unchecked")
	
	public List<DuAnDTO> search(String _strSearch) {
		// TODO Auto-generated method stub
		String sql = "select * from duan where deleted = 0 and tenduan like '%"
				+ _strSearch + "%'";
		System.out.println(sql);
		return this.jdbcTemplate.query(sql, new RowMapper() {
			public Object mapRow(ResultSet rs, int rowNum) throws SQLException {
				return DuAnDTO.mapObject(rs);
			}
		});
	}

	
	public DuAnDTO get(String id) {
		// TODO Auto-generated method stub
		@SuppressWarnings("unchecked")
		List<DuAnDTO> lst = this.jdbcTemplate.query(
				"select * from duan where deleted = 0 and id=" + id,
				new RowMapper() {
					public Object mapRow(ResultSet rs, int rowNum)
							throws SQLException {
						return DuAnDTO.mapObject(rs);
					}
				});
		if (lst.size() == 0)
			return null;
		return lst.get(0);
	}

	
	public boolean insert(DuAnDTO cat) throws SQLException {
		// TODO Auto-generated method stub
		DuAnDTO d=(DuAnDTO)cat;
		System.out.println("insert du an:" + cat.getTenduan());
		try {
			Connection connection = this.jdbcTemplate.getDataSource()
					.getConnection();
			System.out.println("***BEGIN PROC_SAVE_DUAN***");
			CallableStatement stmt = connection
					.prepareCall("{ call PROC_SAVE_DUAN(?,?,?,?,?,?,?,?) }");
			//stmt.registerOutParameter(1, OracleTypes.INTEGER);
			
			//System.out.println("STT : "+d.getStt());
			
			stmt.setString(1, d.getId());
			System.out.println(d.getId());
			stmt.setString(2, d.getTenduan());
			stmt.setInt(3, d.getStt());
			stmt.setLong(4, 0);
			stmt.setString(5, d.getMota());
			stmt.setInt(6, d.getGiamgia());
			stmt.setString(7, d.getUsercreate());
			stmt.setString(8, d.getMa());
			System.out.println("***execute***");
			stmt.execute();
			stmt.close();
			connection.close();
			System.out.println("***END PROC_SAVE_DUAN***");
			return true;
		} catch (Exception e) {
			System.out.println(e.getMessage());
			System.out.println("***Error PROC_SAVE_DUAN***");
			return false;
		}
	}

	
	public boolean update(String id, DuAnDTO cat) {
		// TODO Auto-generated method stub
		DuAnDTO up = (DuAnDTO) cat;
		String sql = "update duan set ma='"+cat.getMa()+"',stt='"+up.getStt()+"',mota='"+up.getMota()+"',giamgia="+up.getGiamgia()+",tenduan='" + up.getTenduan() + "' where id=" + up.getId();
		System.out.println(sql);
		return this.jdbcTemplate.update(sql) > 0;
	}

	
	public boolean delete(String[] ids) {

		// TODO Auto-generated method stub
		String str = StringUtils.join(ids, ",");
		System.out.println(ids);
		return this.jdbcTemplate
				.update("update duan set DELETED = 1 where ID in (" + str
						+ ")") > 0;
	}

}
