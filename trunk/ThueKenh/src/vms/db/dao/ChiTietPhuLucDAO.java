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
import oracle.sql.ARRAY;
import oracle.sql.ArrayDescriptor;

import org.apache.commons.lang3.StringUtils;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.core.RowMapper;

import vms.db.dto.ChiTietPhuLucTuyenKenhDTO;
import vms.db.dto.PhuLucDTO;
import vms.utils.Constances;
import vms.utils.DateUtils;
import vms.utils.VMSUtil;

public class ChiTietPhuLucDAO {
	private JdbcTemplate jdbcTemplate;
	private DataSource jdbcDatasource;
	public ChiTietPhuLucDAO(DaoFactory daoFactory) {
		this.jdbcTemplate = daoFactory.getJdbcTemplate();
		this.jdbcDatasource = daoFactory.getJdbcDataSource();
	}
	
	private static final String SQL_PROC_SAVE_CTPL_TUYENKENH_TMP = "{ call PROC_SAVE_CTPL_TUYENKENH_TMP(?,?,?,?,?,?,?,?) }";
	public void saveChiTietPhuLucTuyenKenh(List<ChiTietPhuLucTuyenKenhDTO> chiTietPhuLucTuyenKenhDTOs,Map<String,String> mapCongThuc) throws Exception {
		this.jdbcTemplate.execute("truncate table CHITIETPHULUC_TUYENKENH_TMP drop storage");
		System.out.println("***BEGIN saveChiTietPhuLucTuyenKenh***");
		Connection connection = this.jdbcDatasource.getConnection();
		CallableStatement stmt = connection.prepareCall(SQL_PROC_SAVE_CTPL_TUYENKENH_TMP);
		for(int i = 0; i<chiTietPhuLucTuyenKenhDTOs.size();i++) {
			ChiTietPhuLucTuyenKenhDTO dto = chiTietPhuLucTuyenKenhDTOs.get(i);
			//Tinh don gia thuc sau khi giam gia
			Long dongia = dto.getDongia() - (dto.getDongia() * dto.getGiamgia()/100);
			String[][] replacements = {
					{Constances.DONGIA, String.valueOf(dongia)}, 
	                {Constances.SOLUONG, String.valueOf(dto.getSoluong())},
	                {Constances.CUOCONG, String.valueOf(dto.getCuoccong())}
					};
			String exp = VMSUtil.replacements(mapCongThuc.get(dto.getCongthuc_id()), replacements);
			Long thanhTien = (long)VMSUtil.calculate(exp);
			System.out.println("thanhTien ="+thanhTien);
			stmt.setString(1,dto.getTuyenkenh_id());
			stmt.setString(2,dto.getCongthuc_id());
			stmt.setInt(3,dto.getSoluong());
			stmt.setLong(4,dto.getCuoccong());
			stmt.setLong(5,dto.getCuocdaunoi());
			stmt.setLong(6,dto.getDongia());
			stmt.setInt(7,dto.getGiamgia());
			stmt.setLong(8,thanhTien);
			stmt.execute();
		}
		stmt.close();
		connection.close();
		System.out.println("***END saveChiTietPhuLucTuyenKenh***");
	}
}