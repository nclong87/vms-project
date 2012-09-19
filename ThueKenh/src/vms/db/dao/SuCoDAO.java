package vms.db.dao;

import java.sql.CallableStatement;
import java.sql.Connection;
import javax.sql.DataSource;
import oracle.jdbc.OracleTypes;
import org.springframework.jdbc.core.JdbcTemplate;
import vms.db.dto.SuCoDTO;

public class SuCoDAO {
	private JdbcTemplate jdbcTemplate;
	private DataSource jdbcDatasource;
	public SuCoDAO(DaoFactory daoFactory) {
		this.jdbcTemplate = daoFactory.getJdbcTemplate();
		this.jdbcDatasource = daoFactory.getJdbcDataSource();
	}
	
	private static final String SQL_SAVE_SUCO = "{ ? = call SAVE_SUCOKENH(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?) }";
	public String save(SuCoDTO dto) throws Exception {
		Connection connection = jdbcTemplate.getDataSource().getConnection();
		CallableStatement stmt = connection.prepareCall(SQL_SAVE_SUCO);
		stmt.registerOutParameter(1, OracleTypes.VARCHAR);
		stmt.setString(2, dto.getId());
		stmt.setString(3, dto.getTuyenkenh_id());
		stmt.setString(4, dto.getFilescan_id());
		stmt.setString(5, dto.getPhuluc_id());
		stmt.setString(6, dto.getThanhtoan_id());
		stmt.setString(7, dto.getLoaisuco());
		stmt.setString(8, dto.getThoidiembatdau());
		stmt.setString(9, dto.getThoidiemketthuc());
		stmt.setString(10, dto.getThoigianmll().toString());
		stmt.setString(11, dto.getNguyennhan());
		stmt.setString(12, dto.getPhuonganxuly());
		stmt.setString(13, dto.getNguoixacnhan());
		stmt.setString(14, String.valueOf(dto.getGiamtrumll()));
		stmt.setString(15, dto.getTrangthai().toString());
		stmt.setString(16, dto.getUsercreate());
		stmt.setString(17, dto.getTimecreate());
		stmt.setString(18, dto.getDeleted().toString());
		stmt.execute();
		return stmt.getString(1);
	}
}
