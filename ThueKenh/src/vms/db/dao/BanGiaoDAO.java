package vms.db.dao;

import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;


import oracle.jdbc.OracleTypes;

import org.apache.commons.lang3.StringUtils;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.core.RowMapper;

import vms.db.dto.BanGiaoDTO;
import vms.db.dto.PhongBanDTO;
import vms.db.dto.PhongBan;
import vms.web.models.FIND_TUYENKENHBANGIAO;

public class BanGiaoDAO  {
	private JdbcTemplate jdbcTemplate;
	public BanGiaoDAO(DaoFactory daoFactory) {
		this.jdbcTemplate=daoFactory.getJdbcTemplate();
		// TODO Auto-generated constructor stub
	}


	@SuppressWarnings("unchecked")
	public List<BanGiaoDTO> search(String _strSearch,int iDisplayStart,int iDisplayLength) throws SQLException {
		// TODO Auto-generated method stub
		System.out.println("{ ? = call FIND_BANGIAO("+_strSearch+","+_strSearch+","+iDisplayLength+") } ");
		Connection connection = jdbcTemplate.getDataSource().getConnection();
		CallableStatement stmt = connection.prepareCall("{ ? = call FIND_BANGIAO(?,?,?) }");
		stmt.registerOutParameter(1, OracleTypes.CURSOR);
		stmt.setInt(2,iDisplayStart);
		stmt.setInt(3,iDisplayLength);
		stmt.setString(4,_strSearch);
		//System.out.println(SQL_FIND_TUYENKENHBANGIAO);
		stmt.execute();
		ResultSet rs = (ResultSet) stmt.getObject(1);
		List<BanGiaoDTO> result = new ArrayList<BanGiaoDTO>();
		while(rs.next()) {
			result.add(BanGiaoDTO.mapObject(rs));
		}
		stmt.close();
		connection.close();
		return result;
	}


	public BanGiaoDTO get(String id) {
		// TODO Auto-generated method stub
		@SuppressWarnings("unchecked")
		List<BanGiaoDTO> lst = this.jdbcTemplate.query(
				"select * from bangiao where deleted = 0 and id=" + id,
				new RowMapper() {
					public Object mapRow(ResultSet rs, int rowNum)
							throws SQLException {
						return BanGiaoDTO.mapObject(rs);
					}
				});
		if (lst.size() == 0)
			return null;
		return lst.get(0);
	}

	
	public boolean insert(PhongBanDTO cat) {
		// TODO Auto-generated method stub
		try {
			Connection connection = this.jdbcTemplate.getDataSource()
					.getConnection();
			
			CallableStatement stmt = connection
					.prepareCall("{ call PROC_SAVE_PHONGBAN(?,?,?,?,?) }");
			//stmt.registerOutParameter(1, OracleTypes.INTEGER);
			System.out.println("***BEGIN PROC_SAVE_PHONGBAN***");
			System.out.println(cat.getId());
			stmt.setString(1, cat.getId());
			stmt.setString(2, cat.getTenphongban());
			stmt.setInt(3, cat.getStt());
			stmt.setLong(4, 0);
			stmt.setString(5, cat.getMa());
			System.out.println("***execute***");
			stmt.execute();
			stmt.close();
			connection.close();
			System.out.println("***END PROC_SAVE_PHONGBAN***");
			return true;
		} catch (Exception e) {
			e.printStackTrace();
			return false;
		}
	}

	
	public boolean update(String id, PhongBanDTO cat) {
		// TODO Auto-generated method stub
		PhongBanDTO up = (PhongBanDTO) cat;
		String sql = "update phongban set ma='"+cat.getMa()+"' ,stt="+up.getStt()+", tenphongban='" + up.getTenphongban()+ "' where id=" + up.getId();
		System.out.println(sql);
		return this.jdbcTemplate.update(sql) > 0;
	}

	
	public boolean delete(String[] ids) {

		// TODO Auto-generated method stub
		String str = StringUtils.join(ids, ",");
		System.out.println(ids);
		return this.jdbcTemplate
				.update("update bangiao set DELETED = 1 where ID in (" + str
						+ ")") > 0;
	}

}