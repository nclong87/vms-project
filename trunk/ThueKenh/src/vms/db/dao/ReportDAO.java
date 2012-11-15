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

import vms.db.dto.DoiTacDTO;
import vms.utils.VMSUtil;

public class ReportDAO {
	@SuppressWarnings("unused")
	private JdbcTemplate jdbcTemplate;
	private DataSource jdbcDatasource;
	private Connection connection;
	private DaoFactory daoFactory;
	public ReportDAO(Connection conn) {
		connection = conn;
	}
	
	public ReportDAO(DaoFactory factory) {
		this.jdbcTemplate = factory.getJdbcTemplate();
		this.jdbcDatasource = factory.getJdbcDataSource();
		this.daoFactory = factory;
	}
	
	/*
	 * Danh sach tuyen kenh da de xuat nhung chua ban giao
	 */
	private static final String SQL_BC_CHUABANGIAO = "{ ? = call BC_CHUABANGIAO(?) }";
	public String reportTuyenKenhChuaBanGiao(String doitac_id) throws Exception {
		if(connection == null)
			connection = this.jdbcDatasource.getConnection();
		System.out.println("***BEGIN reportTuyenKenhChuaBanGiao***");
		/*String tendoitac = "";
		if(doitac_id.isEmpty() == false) {
			DoiTacDAO doiTacDAO = new DoiTacDAO(daoFactory);
			DoiTacDTO dto = doiTacDAO.get(doitac_id);
			tendoitac = dto.getTendoitac();
		}*/
		CallableStatement stmt = connection.prepareCall(SQL_BC_CHUABANGIAO);
		stmt.registerOutParameter(1, OracleTypes.CURSOR);
		stmt.setString(2, doitac_id);
		stmt.execute();
		ResultSet rs = (ResultSet) stmt.getObject(1);
		StringBuffer stringBuffer = new StringBuffer(1024);
		stringBuffer.append("<root>");
		stringBuffer.append("<header></header>");
		stringBuffer.append("<data>");
		int stt = 1;
		while(rs.next()) {
			stringBuffer.append("<row>");
			stringBuffer.append("<stt>"+stt+"</stt>");
			stringBuffer.append(VMSUtil.resultSetToXML(rs));
			stringBuffer.append("</row>");
			stt++;
		}
		stringBuffer.append("</data>");
		stringBuffer.append("</root>");
		stmt.close();
		connection.close();
		return stringBuffer.toString();
	}
	
	/*
	 * Danh sach tuyen kenh da ban giao nhung chua co hop dong
	 */
	private static final String SQL_BC_CHUAHOPDONG = "{ ? = call BC_CHUAHOPDONG(?) }";
	public String reportTuyenKenhDaBanGiaoChuaHopDong(String doitac_id) throws Exception {
		if(connection == null)
			connection = this.jdbcDatasource.getConnection();
		System.out.println("***BEGIN reportTuyenKenhChuaBanGiao***");
		/*String tendoitac = "";
		if(doitac_id.isEmpty() == false) {
			DoiTacDAO doiTacDAO = new DoiTacDAO(daoFactory);
			DoiTacDTO dto = doiTacDAO.get(doitac_id);
			tendoitac = dto.getTendoitac();
		}*/
		
		CallableStatement stmt = connection.prepareCall(SQL_BC_CHUAHOPDONG);
		stmt.registerOutParameter(1, OracleTypes.CURSOR);
		stmt.setString(2, doitac_id);
		stmt.execute();
		ResultSet rs = (ResultSet) stmt.getObject(1);
		StringBuffer stringBuffer = new StringBuffer(1024);
		stringBuffer.append("<root>");
		stringBuffer.append("<header></header>");
		stringBuffer.append("<data>");
		int stt = 1;
		while(rs.next()) {
			stringBuffer.append("<row>");
			stringBuffer.append("<stt>"+stt+"</stt>");
			stringBuffer.append(VMSUtil.resultSetToXML(rs));
			stringBuffer.append("</row>");
			stt++;
		}
		stringBuffer.append("</data>");
		stringBuffer.append("</root>");
		stmt.close();
		connection.close();
		return stringBuffer.toString();
	}
}