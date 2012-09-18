package vms.db.dao;

import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.List;


import org.apache.commons.lang3.StringUtils;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.core.RowMapper;

import vms.db.dto.DoiTacDTO;

public class DoiTacDAO {

	private JdbcTemplate jdbcTemplate;

	public DoiTacDAO(DaoFactory daoFactory) {
		this.jdbcTemplate=daoFactory.getJdbcTemplate();
		// TODO Auto-generated constructor stub
	}

	@SuppressWarnings("unchecked")
	
	public List<DoiTacDTO> get() {
		// TODO Auto-generated method stub
		return this.jdbcTemplate.query(
				"select * from doitac where deleted = 0", new RowMapper() {
					public Object mapRow(ResultSet rs, int rowNum)
							throws SQLException {
						return DoiTacDTO.mapObject(rs);
					}
				});
	}
	@SuppressWarnings("unchecked")
	
	public List<DoiTacDTO> search(String _strSearch) {
		// TODO Auto-generated method stub
		String sql="select * from doitac where deleted = 0 and tendoitac like '%"+_strSearch+"%'";
		System.out.println(sql); 
		return this.jdbcTemplate.query(
				sql, new RowMapper() {
					public Object mapRow(ResultSet rs, int rowNum)
							throws SQLException {
						return DoiTacDTO.mapObject(rs);
					}
				});
	}

	
	public DoiTacDTO get(String id) {
		// TODO Auto-generated method stub
		@SuppressWarnings("unchecked")
		List<DoiTacDTO> lst = this.jdbcTemplate.query(
				"select * from doitac where deleted = 0 and id=" + id,
				new RowMapper() {
					public Object mapRow(ResultSet rs, int rowNum)
							throws SQLException {
						return DoiTacDTO.mapObject(rs);
					}
				});
		if (lst.size() == 0)
			return null;
		return lst.get(0);
	}

	
	public boolean insert(DoiTacDTO cat) throws SQLException {
		// TODO Auto-generated method stub
		System.out.println("insert doitac:" + cat.getTendoitac());
		
		try {
			Connection connection = this.jdbcTemplate.getDataSource()
					.getConnection();
			System.out.println("***BEGIN PROC_SAVE_DOITAC***");
			CallableStatement stmt = connection
					.prepareCall("{ call PROC_SAVE_DOITAC(?,?,?,?) }");
			//stmt.registerOutParameter(1, OracleTypes.INTEGER);
			
			System.out.println("STT : "+cat.getStt());
			
			stmt.setString(1, cat.getId());
			System.out.println(cat.getId());
			stmt.setString(2, cat.getTendoitac());
			stmt.setInt(3, cat.getStt());
			stmt.setLong(4, 0);
			System.out.println("***execute***");
			stmt.execute();
			stmt.close();
			connection.close();
			System.out.println("***END PROC_SAVE_DOITAC***");
			return true;
		} catch (Exception e) {
			System.out.println(e.getMessage());
			System.out.println("***Error PROC_SAVE_DOITAC***");
			return false;
		}
	}

	
	public boolean update(String id, DoiTacDTO cat) {
		// TODO Auto-generated method stub
		DoiTacDTO up = (DoiTacDTO) cat;
		String sql="update doitac set stt="+cat.getStt()+",ma='"+cat.getStt()+"' ,tendoitac='"+up.getTendoitac()+"' where id="+up.getId();
		System.out.println(sql);
		return this.jdbcTemplate.update(sql) > 0;
	}

	
	public boolean delete(String[] ids) {

		// TODO Auto-generated method stub
		String str = StringUtils.join(ids, ",");
		System.out.println(ids);
		return this.jdbcTemplate
				.update("update doitac set DELETED = 1 where ID in (?)",new Object[]{str}) > 0;
	}
	
	@SuppressWarnings("unchecked")
	public List<DoiTacDTO> findAll() {
		return this.jdbcTemplate.query(
				"select * from DOITAC where deleted = 0", new RowMapper() {
					public Object mapRow(ResultSet rs, int rowNum)
							throws SQLException {
						return DoiTacDTO.mapObject(rs);
					}
				});
	}

}
