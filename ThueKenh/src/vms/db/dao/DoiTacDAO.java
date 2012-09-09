package vms.db.dao;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.List;


import org.apache.commons.lang3.StringUtils;
import org.springframework.jdbc.core.RowMapper;

import vms.db.dto.CatalogDTO;
import vms.db.dto.DoiTacDTO;
import vms.db.dto.KhuVucDTO;

public class DoiTacDAO extends CatalogDAO {

	public DoiTacDAO(DaoFactory daoFactory) {
		super(daoFactory);
		// TODO Auto-generated constructor stub
	}

	@SuppressWarnings("unchecked")
	@Override
	public List<CatalogDTO> get() {
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
	@Override
	public List<CatalogDTO> search(String _strSearch) {
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

	@Override
	public CatalogDTO get(String id) {
		// TODO Auto-generated method stub
		@SuppressWarnings("unchecked")
		List<CatalogDTO> lst = this.jdbcTemplate.query(
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

	@Override
	public boolean insert(CatalogDTO cat) throws SQLException {
		// TODO Auto-generated method stub
		System.out.println("insert khuvuc:" + cat.getName());
		return false;
	}

	@Override
	public boolean update(String id, CatalogDTO cat) {
		// TODO Auto-generated method stub
		DoiTacDTO up = (DoiTacDTO) cat;
		String sql="update doitac set tendoitac='"+up.getName()+"',stt="+up.getStt()+" where id="+up.getId();
		System.out.println(sql);
		return this.jdbcTemplate.update(sql) > 0;
	}

	@Override
	public boolean delete(String[] ids) {

		// TODO Auto-generated method stub
		String str = StringUtils.join(ids, ",");
		System.out.println(ids);
		return this.jdbcTemplate
				.update("update doitac set DELETED = 1 where ID in (?)",new Object[]{str}) > 0;
	}

}
