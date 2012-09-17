package vms.db.dao;

import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.List;

import org.apache.commons.lang3.StringUtils;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.core.RowMapper;


import vms.db.dto.KhuVucDTO;
import vms.db.dto.KhuVuc;

public class KhuVucDao {
	private JdbcTemplate jdbcTemplate;
	public KhuVucDao(DaoFactory daoFactory) {
		this.jdbcTemplate=daoFactory.getJdbcTemplate();
		// TODO Auto-generated constructor stub
	}

	@SuppressWarnings("unchecked")
	public List<KhuVuc> getAll() {
		return this.jdbcTemplate.query(
				"select * from khuvuc where deleted = 0", new RowMapper() {
					public Object mapRow(ResultSet rs, int rowNum)
							throws SQLException {
						return KhuVucDTO.mapObject(rs);
					}
				});
	}

	@SuppressWarnings("unchecked")
	public List<KhuVucDTO> findAll() {
		// TODO Auto-generated method stub
		return this.jdbcTemplate.query(
			    "select * from khuvuc where deleted = 0",
			    new RowMapper() {
			        public Object mapRow(ResultSet rs, int rowNum) throws SQLException {
			        	return KhuVucDTO.mapObject(rs);
			        }
			    });
	}

	
	@SuppressWarnings("unchecked")
	
	public List<KhuVucDTO> get() {
		// TODO Auto-generated method stub
		return this.jdbcTemplate.query(
			    "select * from khuvuc where deleted = 0",
			    new RowMapper() {
			        public Object mapRow(ResultSet rs, int rowNum) throws SQLException {
			        	return KhuVucDTO.mapObject(rs);
			        }
			    });
	}

	
	public KhuVucDTO get(String id) {
		// TODO Auto-generated method stub
		@SuppressWarnings("unchecked")
		List<KhuVucDTO> lst= this.jdbcTemplate.query(
			    "select * from khuvuc where deleted = 0 and id="+id,
			    new RowMapper() {
			        public Object mapRow(ResultSet rs, int rowNum) throws SQLException {
			        	return KhuVucDTO.mapObject(rs);
			        }
			    });
		if(lst.size()==0)
			return null;
		return lst.get(0);
	}

	
	public boolean insert(KhuVucDTO cat) throws SQLException {
		// TODO Auto-generated method stub
		try {
			Connection connection = this.jdbcTemplate.getDataSource()
					.getConnection();
			System.out.println("***BEGIN PROC_SAVE_KHUVUC***");
			CallableStatement stmt = connection
					.prepareCall("{ call PROC_SAVE_KHUVUC(?,?,?,?) }");
			//stmt.registerOutParameter(1, OracleTypes.INTEGER);
			
			System.out.println("STT : "+cat.getStt());
			
			stmt.setString(1, cat.getId());
			System.out.println(cat.getId());
			stmt.setString(2, cat.getTenkhuvuc());
			stmt.setInt(3, cat.getStt());
			stmt.setLong(4, 0);
			System.out.println("***execute***");
			stmt.execute();
			stmt.close();
			connection.close();
			System.out.println("***END PROC_SAVE_KHUVUC***");
			return true;
		} catch (Exception e) {
			System.out.println(e.getMessage());
			System.out.println("***Error PROC_SAVE_KHUVUC***");
			return false;
		}
	}

	
	public boolean update(String id, KhuVucDTO up) {
		// TODO Auto-generated method stub
		String sql="update khuvuc set stt="+up.getStt()+", tenkhuvuc='"+up.getTenkhuvuc()+"' where id="+up.getId();
		System.out.println(sql);
		return this.jdbcTemplate.update(sql)>0;
	}

	
	public boolean delete(String[] ids) {
		
		// TODO Auto-generated method stub
		String str = StringUtils.join(ids, ",");
		System.out.println(ids);
		return this.jdbcTemplate.update("update khuvuc set DELETED = 1 where ID in ("+str+")")>0;
	}

}