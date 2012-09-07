package vms.db.dao;

import java.sql.SQLException;
import java.util.List;

import org.springframework.jdbc.core.JdbcTemplate;

import vms.db.dto.CatalogDTO;
/*
 * interface of catalog methods
 */
public class CatalogDAO {
	//the jdbctemplate
	protected JdbcTemplate jdbcTemplate;
	//deny default constructor
	private CatalogDAO() {
	}
	//constructor with factory
	public CatalogDAO(DaoFactory daoFactory) {
		this.jdbcTemplate = daoFactory.getJdbcTemplate();
	}
	/*
	 * Get all catalogs
	 */
	public List<CatalogDTO> get(){return null;}
	/*
	 * Search by name
	 */
	public List<CatalogDTO> search(String _strSearch){return null;}
	/*
	 * Get a catalog
	 */
	public CatalogDTO get(long id){return null;}
	/*
	 * insert a catalog into database
	 */
	public boolean insert(CatalogDTO cat) throws SQLException{return false;}
	/*
	 * update a catalog into database
	 */
	public boolean update(long id,CatalogDTO cat){return false;}
	/*
	 * delete a catalog from database
	 */
	public boolean delete(String[] ids){return false;}
}
