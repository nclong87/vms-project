package vms.db.dao;

import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.List;

import oracle.jdbc.OracleTypes;
import oracle.sql.ARRAY;
import oracle.sql.ArrayDescriptor;

import org.apache.commons.lang3.StringUtils;
import org.springframework.jdbc.core.RowMapper;
import org.springframework.jdbc.core.SqlTypeValue;

import vms.db.dto.CatalogDTO;
import vms.db.dto.PhongBan;
import vms.db.dto.PhongBanDTO;

public class PhongBanDao extends CatalogDAO {

	public PhongBanDao(DaoFactory daoFactory) {
		super(daoFactory);
		// TODO Auto-generated constructor stub
	}

	@SuppressWarnings("unchecked")
	public List<PhongBan> getAll() {
		return this.jdbcTemplate.query(
				"select * from phongban where deleted = 0", new RowMapper() {
					public Object mapRow(ResultSet rs, int rowNum)
							throws SQLException {
						return PhongBan.mapObject(rs);
					}
				});
	}

	@SuppressWarnings("unchecked")
	@Override
	public List<CatalogDTO> search(String _strSearch) {
		// TODO Auto-generated method stub
		return this.jdbcTemplate.query(
				"select * from phongban where deleted = 0 and tenphongban like '%"
						+ _strSearch + "%'", new RowMapper() {
					public Object mapRow(ResultSet rs, int rowNum)
							throws SQLException {
						return PhongBanDTO.mapObject(rs);
					}
				});
	}

	@SuppressWarnings("unchecked")
	@Override
	public List<CatalogDTO> get() {
		// TODO Auto-generated method stub
		return this.jdbcTemplate.query(
				"select * from phongban where deleted = 0", new RowMapper() {
					public Object mapRow(ResultSet rs, int rowNum)
							throws SQLException {
						return PhongBanDTO.mapObject(rs);
					}
				});
	}

	@Override
	public CatalogDTO get(String id) {
		// TODO Auto-generated method stub
		@SuppressWarnings("unchecked")
		List<CatalogDTO> lst = this.jdbcTemplate.query(
				"select * from phongban where deleted = 0 and id=" + id,
				new RowMapper() {
					public Object mapRow(ResultSet rs, int rowNum)
							throws SQLException {
						return PhongBanDTO.mapObject(rs);
					}
				});
		if (lst.size() == 0)
			return null;
		return lst.get(0);
	}

	@Override
	public boolean insert(CatalogDTO cat) {
		// TODO Auto-generated method stub
		try {
			Connection connection = this.jdbcTemplate.getDataSource()
					.getConnection();
			
			CallableStatement stmt = connection
					.prepareCall("{ call PROC_SAVE_PHONGBAN(?,?,?,?) }");
			//stmt.registerOutParameter(1, OracleTypes.INTEGER);
			stmt.setString(1, cat.getId());
			System.out.println(cat.getId());
			stmt.setString(2, cat.getName());
			stmt.setInt(3, 0);
			stmt.setInt(4, cat.getStt());
			System.out.println("***BEGIN PROC_SAVE_PHONGBAN***");
			stmt.execute();
			stmt.close();
			connection.close();
			System.out.println("***END PROC_SAVE_PHONGBAN***");
			return true;
		} catch (Exception e) {
			System.out.println(e.getMessage());
			return false;
		}
	}

	@Override
	public boolean update(String id, CatalogDTO cat) {
		// TODO Auto-generated method stub
		PhongBanDTO up = (PhongBanDTO) cat;
		String sql = "update phongban set tenphongban='" + up.getName()
				+ "' where id=" + up.getId();
		System.out.println(sql);
		return this.jdbcTemplate.update(sql) > 0;
	}

	@Override
	public boolean delete(String[] ids) {

		// TODO Auto-generated method stub
		String str = StringUtils.join(ids, ",");
		System.out.println(ids);
		return this.jdbcTemplate
				.update("update phongban set DELETED = 1 where ID in (" + str
						+ ")") > 0;
	}

}