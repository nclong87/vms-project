package vms.db.dao;

import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.List;

import oracle.jdbc.OracleTypes;

import org.apache.commons.lang3.StringUtils;
import org.springframework.jdbc.core.RowMapper;

import com.sun.crypto.provider.RSACipher;

import vms.db.dto.CatalogDTO;
import vms.db.dto.KhuVuc;
import vms.db.dto.KhuVucDTO;

public class KhuVucDao extends CatalogDAO {
	public KhuVucDao(DaoFactory daoFactory) {
		super(daoFactory);
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
	@Override
	public List<CatalogDTO> get() {
		// TODO Auto-generated method stub
		return this.jdbcTemplate.query(
			    "select * from khuvuc where deleted = 0",
			    new RowMapper() {
			        public Object mapRow(ResultSet rs, int rowNum) throws SQLException {
			        	return KhuVucDTO.mapObject(rs);
			        }
			    });
	}

	@Override
	public CatalogDTO get(String id) {
		// TODO Auto-generated method stub
		@SuppressWarnings("unchecked")
		List<CatalogDTO> lst= this.jdbcTemplate.query(
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

	@Override
	public boolean insert(CatalogDTO cat) throws SQLException {
		// TODO Auto-generated method stub
		System.out.println("insert khuvuc:"+cat.getName());
		Connection connection = jdbcTemplate.getDataSource().getConnection();
		CallableStatement stmt = connection.prepareCall( "{ ? = call SAVE_KHUVUC(?,?,?) }");
		stmt.registerOutParameter(1, OracleTypes.INTEGER);
		stmt.setString(2, cat.getId());
		stmt.setString(3, cat.getName());
		stmt.setInt(4, cat.getStt());
		stmt.execute();
		return stmt.getLong(1)>0;
	}

	@Override
	public boolean update(String id, CatalogDTO cat) {
		// TODO Auto-generated method stub
		KhuVucDTO up=(KhuVucDTO)cat;
		String sql="update khuvuc set tenkhuvuc='"+up.getName()+"' where id="+up.getId();
		System.out.println(sql);
		return this.jdbcTemplate.update(sql)>0;
	}

	@Override
	public boolean delete(String[] ids) {
		
		// TODO Auto-generated method stub
		String str = StringUtils.join(ids, ",");
		System.out.println(ids);
		return this.jdbcTemplate.update("update khuvuc set DELETED = 1 where ID in ("+str+")")>0;
	}

}