package vms.db.dao;

import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.List;
import java.util.Map;


import org.apache.commons.lang3.StringUtils;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.core.RowMapper;

import vms.db.dto.DoiTacDTO;
import vms.utils.VMSUtil;

public class DoiTacDAO {

	private JdbcTemplate jdbcTemplate;
	//private Connection connection;
	/*public DoiTacDAO(Connection conn) {
		//connection = conn;
		
	}*/
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
	
	public List<Map<String, Object>> search(String _strSearch) {
		// TODO Auto-generated method stub
		String sql="select t.*,t1.TENKHUVUC from doitac t left join khuvuc t1 on t.KHUVUC_ID = t1.ID where t.deleted = 0 ";
		System.out.println(sql); 
		return this.jdbcTemplate.query(
				sql, new RowMapper() {
					public Object mapRow(ResultSet rs, int rowNum)
							throws SQLException {
						Map<String, Object> map = VMSUtil.resultSetToMap(rs);
						map.put("stt", rowNum);
						return map;
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
					.prepareCall("{ call PROC_SAVE_DOITAC(?,?,?,?,?,?) }");
			//stmt.registerOutParameter(1, OracleTypes.INTEGER);
			
			System.out.println("STT : "+cat.getStt());
			
			stmt.setString(1, cat.getId());
			stmt.setString(2, cat.getTendoitac());
			stmt.setInt(3, cat.getStt());
			stmt.setLong(4, 0);
			stmt.setString(5, cat.getMa());
			stmt.setString(6, cat.getKhuvuc_id());
			System.out.println("***execute***");
			stmt.execute();
			stmt.close();
			connection.close();
			System.out.println("***END PROC_SAVE_DOITAC***");
			return true;
		} catch (Exception e) {
			e.printStackTrace();
			System.out.println("***Error PROC_SAVE_DOITAC***");
			return false;
		}
	}

	
	public boolean update(String id, DoiTacDTO cat) {
		// TODO Auto-generated method stub
		DoiTacDTO up = (DoiTacDTO) cat;
		String sql="update doitac set stt="+cat.getStt()+",ma='"+cat.getMa()+"' ,tendoitac='"+up.getTendoitac()+"',khuvuc_id="+up.getKhuvuc_id()+" where id="+up.getId();
		System.out.println(sql);
		return this.jdbcTemplate.update(sql) > 0;
	}

	
	public boolean delete(String[] ids) {

		// TODO Auto-generated method stub
		String str = StringUtils.join(ids, ",");
		System.out.println(ids);
		return this.jdbcTemplate
				.update("update doitac set DELETED = "+System.currentTimeMillis()+" where ID in (?)",new Object[]{str}) > 0;
	}
	
	@SuppressWarnings("unchecked")
	public List<Map<String,Object>> findAll() {
		return this.jdbcTemplate.query(
				"select * from DOITAC where deleted = 0", new RowMapper() {
					public Object mapRow(ResultSet rs, int rowNum)
							throws SQLException {
						return VMSUtil.resultSetToMap(rs);
					}
				});
	}

}
