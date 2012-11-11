package vms.db.dao;


import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;
import javax.sql.DataSource;
import oracle.jdbc.OracleTypes;
import org.springframework.jdbc.core.JdbcTemplate;
import vms.utils.VMSUtil;

public class ReportDao {
	@SuppressWarnings("unused")
	private JdbcTemplate jdbcTemplate;
	private DataSource jdbcDatasource;
	private Connection connection;
	public ReportDao(Connection conn) {
		connection = conn;
	}
	public ReportDao(DaoFactory daoFactory) {
		this.jdbcTemplate = daoFactory.getJdbcTemplate();
		this.jdbcDatasource = daoFactory.getJdbcDataSource();
	}
	
	private static final String SQL_BC_CHUABANGIAO = "{ ? = call BC_CHUABANGIAO(?) }";
	public List<Map<String,Object>> reportTuyenKenhChuaBanGiao(String doitac_id) throws Exception {
		if(connection == null)
			connection = this.jdbcDatasource.getConnection();
		System.out.println("***BEGIN reportTuyenKenhChuaBanGiao***");
		CallableStatement stmt = connection.prepareCall(SQL_BC_CHUABANGIAO);
		stmt.registerOutParameter(1, OracleTypes.CURSOR);
		stmt.setString(2, doitac_id);
		stmt.execute();
		ResultSet rs = (ResultSet) stmt.getObject(1);
		List<Map<String,Object>> lstResult = new ArrayList<Map<String,Object>>();
		while(rs.next()) {
			lstResult.add(VMSUtil.resultSetToMap(rs));
		}
		stmt.close();
		connection.close();
		return lstResult;
	}
}