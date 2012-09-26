package vms.db.dao;

import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;
import javax.sql.DataSource;
import oracle.jdbc.OracleTypes;

import org.apache.commons.lang3.StringUtils;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.core.RowMapper;

import vms.db.dto.BienBanVanHanhKenhDTO;
import vms.db.dto.SuCoDTO;
import vms.utils.DateUtils;
import vms.utils.VMSUtil;

public class BienBanVanHanhKenhDAO {
	private JdbcTemplate jdbcTemplate;
	private DataSource jdbcDatasource;

	public BienBanVanHanhKenhDAO(DaoFactory daoFactory) {
		this.jdbcTemplate = daoFactory.getJdbcTemplate();
		this.jdbcDatasource = daoFactory.getJdbcDataSource();
	}

	private static final String SQL_SAVE_BIENBANVANHANHKENH = "{ ? = call SAVE_BIENBANVANHANH(?,?,?,?,?,?,?,?) }";

	public String save(BienBanVanHanhKenhDTO dto) throws Exception {
		System.out.println("begin call SQL_SAVE_BIENBANVANHANHKENH");
		Connection connection = jdbcTemplate.getDataSource().getConnection();
		CallableStatement stmt = connection
				.prepareCall(SQL_SAVE_BIENBANVANHANHKENH);
		stmt.registerOutParameter(1, OracleTypes.VARCHAR);
		stmt.setString(2, dto.getId());
		stmt.setString(3, dto.getSobienban());
		stmt.setString(4, dto.getUsercreate());
		stmt.setString(5, dto.getTimecreate());
		stmt.setInt(6, dto.getDeleted());
		stmt.setString(7, dto.getFilename());
		stmt.setString(8, dto.getFilepath());
		stmt.setInt(9, dto.getFilesize());
		stmt.execute();
		System.out.println("end call SAVE_BIENBANVANHANHKENH");
		return stmt.getString(1);
	}

	private static final String SQL_FN_FIND_BIENBANVANHANHKENH = "{ ? = call FN_FIND_BIENBANVANHANHKENH(?,?,?) }";

	public List<BienBanVanHanhKenhDTO> findBienBanVanHanhKenh(
			int iDisplayStart, int iDisplayLength,
			Map<String, String> conditions) throws SQLException {
		Connection connection = jdbcDatasource.getConnection();
		CallableStatement stmt = connection
				.prepareCall(SQL_FN_FIND_BIENBANVANHANHKENH);
		stmt.registerOutParameter(1, OracleTypes.CURSOR);
		stmt.setInt(2, iDisplayStart);
		stmt.setInt(3, iDisplayLength);
		stmt.setString(4, conditions.get("sobienban"));
		stmt.execute();
		ResultSet rs = (ResultSet) stmt.getObject(1);
		List<BienBanVanHanhKenhDTO> result = new ArrayList<BienBanVanHanhKenhDTO>();
		while (rs.next()) {
			result.add(BienBanVanHanhKenhDTO.mapObject(rs));
		}
		stmt.close();
		connection.close();
		return result;
	}

	public BienBanVanHanhKenhDTO findById(String id) {
		return (BienBanVanHanhKenhDTO) this.jdbcTemplate.queryForObject(
				"SELECT * FROM BIENBANVANHANH WHERE id = ? AND DELETED = 0",
				new Object[] { id }, new RowMapper() {
					@Override
					public Object mapRow(ResultSet rs, int arg1)
							throws SQLException {
						return BienBanVanHanhKenhDTO.mapObject(rs);
					}
				});
	}

	public void deleteByIds(String[] ids) {
		String str = StringUtils.join(ids, ",");
		this.jdbcTemplate
				.update("update BIENBANVANHANH set DELETED = 1 where ID in ("
						+ str + ")");
	}

	private static final String SQL_DETAIL_BIENBANVANHANHKENH = "SELECT * FROM BIENBANVANHANH "
												+ "WHERE id=? AND DELETED=0";

	@SuppressWarnings("unchecked")
	public Map<String, Object> getDetail(String id) {
		List<Map<String, Object>> list = this.jdbcTemplate.query(
				SQL_DETAIL_BIENBANVANHANHKENH, new Object[] { id }, new RowMapper() {
					@Override
					public Object mapRow(ResultSet rs, int arg1)
							throws SQLException {
						Map<String, Object> map = VMSUtil.resultSetToMap(rs);
						map.put("timecreate", DateUtils.formatDate(
								rs.getDate("timecreate"),
								DateUtils.SDF_DDMMYYYY));
						return map;
					}
				});
		if (list.isEmpty())
			return null;
		return list.get(0);
	}
}
