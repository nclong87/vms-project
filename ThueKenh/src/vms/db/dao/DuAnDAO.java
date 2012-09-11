package vms.db.dao;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.List;

import org.apache.commons.lang3.StringUtils;
import org.springframework.jdbc.core.RowMapper;

import vms.db.dto.CatalogDTO;
import vms.db.dto.DuAnDTO;

public class DuAnDAO extends CatalogDAO {

	public DuAnDAO(DaoFactory daoFactory) {
		super(daoFactory);
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
	@Override
	public List<CatalogDTO> get() {
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
	@Override
	public List<CatalogDTO> search(String _strSearch) {
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

	@Override
	public CatalogDTO get(String id) {
		// TODO Auto-generated method stub
		@SuppressWarnings("unchecked")
		List<CatalogDTO> lst = this.jdbcTemplate.query(
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

	@Override
	public boolean insert(CatalogDTO cat) throws SQLException {
		// TODO Auto-generated method stub
		System.out.println("insert khuvuc:" + cat.getName());
		return false;
	}

	@Override
	public boolean update(String id, CatalogDTO cat) {
		// TODO Auto-generated method stub
		DuAnDTO up = (DuAnDTO) cat;
		String sql = "update duan set tenduan='" + up.getName() + "' where id=" + up.getId();
		System.out.println(sql);
		return this.jdbcTemplate.update(sql) > 0;
	}

	@Override
	public boolean delete(String[] ids) {

		// TODO Auto-generated method stub
		String str = StringUtils.join(ids, ",");
		System.out.println(ids);
		return this.jdbcTemplate
				.update("update duan set DELETED = 1 where ID in (" + str
						+ ")") > 0;
	}

}
