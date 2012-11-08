package vms.db.dao;


import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;
import javax.sql.DataSource;
import oracle.jdbc.OracleTypes;

import org.apache.commons.lang3.StringUtils;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.core.RowMapper;

import vms.db.dto.BienBanVanHanhKenhDTO;
import vms.db.dto.ChiTietPhuLucDTO;
import vms.db.dto.ChiTietPhuLucTuyenKenhDTO;
import vms.utils.Constances;
import vms.utils.VMSUtil;

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