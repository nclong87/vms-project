package vms.db.dao;


import java.sql.ResultSet;
import java.sql.SQLException;
import javax.sql.DataSource;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.core.RowMapper;

import vms.db.dto.ChiTietPhuLucTuyenKenhDTO;

public class ChiTietPhuLucTuyenKenhDAO {
	private JdbcTemplate jdbcTemplate;
	private DataSource jdbcDatasource;
	public ChiTietPhuLucTuyenKenhDAO(DaoFactory daoFactory) {
		this.jdbcTemplate = daoFactory.getJdbcTemplate();
		this.jdbcDatasource = daoFactory.getJdbcDataSource();
	}
	
	public ChiTietPhuLucTuyenKenhDTO findByPhuLuc_TuyenKenh(String phuluc_id,String tuyenkenh_id) {
		return (ChiTietPhuLucTuyenKenhDTO) this.jdbcTemplate.queryForObject(
				"SELECT * FROM CHITIETPHULUC_TUYENKENH WHERE PHULUC_ID = ? AND TUYENKENH_ID = ?",
				new Object[] { phuluc_id,tuyenkenh_id }, new RowMapper() {
					@Override
					public Object mapRow(ResultSet rs, int arg1)
							throws SQLException {
						return ChiTietPhuLucTuyenKenhDTO.mapObject(rs);
					}
				});
	}
	
}