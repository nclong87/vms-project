package vms.db.dao;


import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.List;
import javax.sql.DataSource;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.core.RowMapper;
import vms.db.dto.LoaiGiaoTiep;

public class LoaiGiaoTiepDao {
	private JdbcTemplate jdbcTemplate;
	private DataSource jdbcDatasource;
	public LoaiGiaoTiepDao(DaoFactory daoFactory) {
		this.jdbcTemplate = daoFactory.getJdbcTemplate();
		this.jdbcDatasource = daoFactory.getJdbcDataSource();
	}
	
	@SuppressWarnings("unchecked")
	public List<LoaiGiaoTiep> getAll() {
		return this.jdbcTemplate.query(
			"select * from LOAIGIAOTIEP where deleted = 0", new RowMapper() {
				public Object mapRow(ResultSet rs, int rowNum)
						throws SQLException {
					return LoaiGiaoTiep.mapObject(rs);
				}
			});
	}
	
}