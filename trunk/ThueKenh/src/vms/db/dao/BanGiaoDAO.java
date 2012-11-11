package vms.db.dao;

import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import oracle.jdbc.OracleTypes;

import org.apache.commons.lang3.StringUtils;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.core.RowMapper;

import vms.db.dto.BanGiaoDTO;
import vms.utils.VMSUtil;

public class BanGiaoDAO  {
	private JdbcTemplate jdbcTemplate;
	public BanGiaoDAO(DaoFactory daoFactory) {
		this.jdbcTemplate=daoFactory.getJdbcTemplate();
		// TODO Auto-generated constructor stub
	}


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

	public BanGiaoDTO findById(String id) {
		return (BanGiaoDTO) this.jdbcTemplate.queryForObject("select * from BANGIAO where ID = ? and DELETED = 0" ,new Object[] {id}, new RowMapper() {
			@Override
			public Object mapRow(ResultSet rs, int arg1) throws SQLException {
				return BanGiaoDTO.mapObject(rs);
			}
		});
	}
	
	private static final String SQL_SAVE_BANGIAO = "{ ? = call SAVE_BANGIAO(?,?,?,?,?,?,?) }";
	public String save(BanGiaoDTO dto) throws Exception {
		Connection connection = jdbcTemplate.getDataSource().getConnection();
		CallableStatement stmt = connection.prepareCall(SQL_SAVE_BANGIAO);
		stmt.registerOutParameter(1, OracleTypes.VARCHAR);
		stmt.setString(2, dto.getId());
		stmt.setString(3, dto.getSobienban());
		stmt.setString(4, dto.getUsercreate());
		stmt.setString(5, dto.getTimecreate());
		stmt.setString(6, dto.getFilename());
		stmt.setString(7, dto.getFilepath());
		stmt.setString(8, dto.getFilesize());
		stmt.execute();
		return stmt.getString(1);
	}
	
	public void deleteByIds(String[] ids) {
		String str = StringUtils.join(ids, ",");
		this.jdbcTemplate.update("update BANGIAO set DELETED = "+System.currentTimeMillis()+" where ID in ("+str+")");
	}
	
	private static final String SQL_DETAIL_BANGIAO = "select * from BANGIAO where ID=?";
	@SuppressWarnings("unchecked")
	public Map<String,Object> getDetail(String id) {
		List<Map<String,Object>> list =  this.jdbcTemplate.query(SQL_DETAIL_BANGIAO ,new Object[] {id}, new RowMapper() {
			@Override
			public Object mapRow(ResultSet rs, int arg1) throws SQLException {
				return BanGiaoDTO.resultSetToMap(rs);
			}
		});
		if(list.isEmpty()) return null;
		return list.get(0);
	}
}