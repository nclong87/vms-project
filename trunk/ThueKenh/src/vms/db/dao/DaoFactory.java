package vms.db.dao;

import javax.sql.DataSource;

import org.springframework.jdbc.core.JdbcTemplate;

public class DaoFactory {
	
	private JdbcTemplate jdbcTemplate;
	private DataSource jdbcDataSource;
	 public void setDataSource(DataSource dataSource) {
		 this.jdbcTemplate = new JdbcTemplate(dataSource);
	 }
	public DataSource getDataSource() {
		return this.jdbcTemplate.getDataSource();
	}
	public void setJdbcDataSource(DataSource dataSource) {
		this.jdbcDataSource = dataSource;
	}
	public DataSource getJdbcDataSource() {
		return this.jdbcDataSource;
	}
	public JdbcTemplate getJdbcTemplate() {
		return this.jdbcTemplate;
	}
	/*@SuppressWarnings("rawtypes")
	public Object getDao(String className) {
		try {
			Class cl = Class.forName(className);
			Object obj = cl.newInstance()
			return obj;
		} catch (ClassNotFoundException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (InstantiationException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (IllegalAccessException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return null;
	}*/
}