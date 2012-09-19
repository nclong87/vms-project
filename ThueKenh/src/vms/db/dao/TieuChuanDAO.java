package vms.db.dao;

import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.List;

import org.apache.commons.lang3.StringUtils;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.core.RowMapper;

import vms.db.dto.TieuChuanDTO;

public class TieuChuanDAO{

	private JdbcTemplate jdbcTemplate;
	public TieuChuanDAO(DaoFactory daoFactory) {
		this.jdbcTemplate=daoFactory.getJdbcTemplate();
		// TODO Auto-generated constructor stub
	}

	@SuppressWarnings("unchecked")
	public List<TieuChuanDTO> getAll() {
		return this.jdbcTemplate.query(
				"select * from tieuchuan where deleted = 0 order by stt", new RowMapper() {
					public Object mapRow(ResultSet rs, int rowNum)
							throws SQLException {
						return TieuChuanDTO.mapObject(rs);
					}
				});
	}

	@SuppressWarnings("unchecked")
	public List<TieuChuanDTO> search(String _strSearch) {
		// TODO Auto-generated method stub
		return this.jdbcTemplate.query(
				"select * from tieuchuan where deleted = 0 and tentieuchuan like '%"
						+ _strSearch + "%'", new RowMapper() {
					public Object mapRow(ResultSet rs, int rowNum)
							throws SQLException {
						return TieuChuanDTO.mapObject(rs);
					}
				});
	}

	@SuppressWarnings("unchecked")
	
	public List<TieuChuanDTO> get() {
		// TODO Auto-generated method stub
		return this.jdbcTemplate.query(
				"select * from tieuchuan where deleted = 0  order by stt", new RowMapper() {
					public Object mapRow(ResultSet rs, int rowNum)
							throws SQLException {
						return TieuChuanDTO.mapObject(rs);
					}
				});
	}

	public TieuChuanDTO get(String id) {
		// TODO Auto-generated method stub
		@SuppressWarnings("unchecked")
		List<TieuChuanDTO> lst = this.jdbcTemplate.query(
				"select * from tieuchuan where deleted = 0 and id=" + id,
				new RowMapper() {
					public Object mapRow(ResultSet rs, int rowNum)
							throws SQLException {
						return TieuChuanDTO.mapObject(rs);
					}
				});
		if (lst.size() == 0)
			return null;
		return lst.get(0);
	}

	
	public boolean insert(TieuChuanDTO cat) {
		// TODO Auto-generated method stub
		try {
			Connection connection = this.jdbcTemplate.getDataSource()
					.getConnection();
			
			CallableStatement stmt = connection
					.prepareCall("{ call PROC_SAVE_TIEUCHUAN(?,?,?,?,?) }");
			//stmt.registerOutParameter(1, OracleTypes.INTEGER);
			System.out.println("***BEGIN PROC_SAVE_TIEUCHUAN***");
			System.out.println(cat.getId());
			stmt.setString(1, cat.getId());
			stmt.setString(2, cat.getTentieuchuan());
			stmt.setInt(3, cat.getStt());
			stmt.setLong(4, 0);
			stmt.setString(5, cat.getMa());
			System.out.println("***execute***");
			stmt.execute();
			stmt.close();
			connection.close();
			System.out.println("***END PROC_SAVE_TIEUCHUAN***");
			return true;
		} catch (Exception e) {
			System.out.println(e.getMessage());
			return false;
		}
	}

	
	public boolean update(String id, TieuChuanDTO cat) {
		// TODO Auto-generated method stub
		TieuChuanDTO up = (TieuChuanDTO) cat;
		String sql = "update tieuchuan set ma='"+cat.getMa()+"' ,stt="+up.getStt()+", tentieuchuan='" + up.getTentieuchuan()+ "' where id=" + up.getId();
		System.out.println(sql);
		return this.jdbcTemplate.update(sql) > 0;
	}

	
	public boolean delete(String[] ids) {

		// TODO Auto-generated method stub
		String str = StringUtils.join(ids, ",");
		System.out.println(ids);
		return this.jdbcTemplate
				.update("update tieuchuan set DELETED = 1 where ID in (" + str
						+ ")") > 0;
	}

}
